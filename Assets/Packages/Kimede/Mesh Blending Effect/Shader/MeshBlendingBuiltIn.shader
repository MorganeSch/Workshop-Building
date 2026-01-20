Shader "Kimede/MeshBlendingBuiltin"
{
    Properties
    {
        [Header(Quality)]
       	[IntRange] _ProcessingIterations("Steps (Performance)", Range(1,8)) = 1
	   [Header(Look)]
	    _BlendingRadius("Blend Radius", Range(0.01, 1)) = 0.1
       	[IntRange] _ScalingFactor("Scaling Factor",Range(1,500)) = 50
	    _DistanceFade("Distance Fade",Range(0, 10)) = 2
	    _ColorIntensity("Color Saturation", Range(0, 5)) = 1.0
	    _OpacityLevel("Blend Transparency", Range(0, 5)) = 1.0
		[Header(Filtering)]
	   	    _SurfaceThreshold("Surface Threshold (0-1)",Range(0, 1)) = 0.5
	   	    _EntityTolerance("Entity Tolerance", Range(-1, 1)) = 0.2

	   [Header(Range)]
	    _MinimumRange("Min Active Distance",float) = 0.1
	    _MaximumRange("Max Active Distance",float) = 100
	    _RangeFalloff("Outside Active Distance",float) = 3
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always Blend Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            CBUFFER_START(UnityPerMaterial)
   			int _ProcessingIterations;
			int _ScalingFactor;
			float _BlendingRadius;
			float _DistanceFade;
			float _MinimumRange;
			float _MaximumRange;
			float _RangeFalloff;
			float _SurfaceThreshold;
			float _ColorIntensity;
			float _OpacityLevel;
			float _EntityTolerance;
            int _Enabled;
			CBUFFER_END

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 screenPos : TEXCOORD1;

            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }

            sampler2D _CameraDepthTexture;
            sampler2D _MainTex;
            sampler2D _ObjectIDTexture;
            sampler2D _ObjectDepthTexture;

                        			

float2 FindClosestSeam(float2 UV, float4 entityColor, float3 surfaceNormal, float blendingScale)
{
    float2 bestSeam = float2(0.0, 0.0);
    float bestDist = 999999.0;

    float maxRadius = blendingScale * 4.0;
    int steps = _ProcessingIterations;

    [unroll(8)]
    for(int step = 0; step < steps; step++) {
        float currentRadius = maxRadius * pow(0.6, step);


        float2 directions[8] = {
            float2(0, -1 ),
            float2(1, 0),
            float2(0, 1 ),
            float2(-1, 0),
            float2(0, -2 ),
            float2(2, 0),
            float2(0, 2 ),
            float2(-2, 0)
          
        };

        [unroll(8)]
        for(int i = 0; i < 8; i++) {
            float2 offset = directions[i] * currentRadius;
            float2 sampleUV = UV + offset;

            if (sampleUV.x < 0.0 || sampleUV.x > 1.0 || sampleUV.y < 0.0 || sampleUV.y > 1.0) continue;

           float4 sampleID =  tex2D(_ObjectIDTexture,sampleUV);

            if (abs(sampleID.x - entityColor.x) > _EntityTolerance) {
                float3 surfaceB = (sampleID.yzw) * 2.0 - 1.0;
                float surfaceDiff = length(surfaceB - surfaceNormal);

                if (surfaceDiff > _SurfaceThreshold) {
                    float dist = length(offset);
                    if (dist < bestDist) {
                        bestDist = dist;
                        bestSeam = offset;
                    }
                }
            }
        }

        if (bestDist < blendingScale) break;
    }

    return bestSeam;
}



float4 frag (v2f IN) : SV_Target {

             float2 screenCoords = IN.uv;
			    
			    
               float4 primaryColor = tex2D(_MainTex, screenCoords);
                   

              //  float entityDepth = LinearEyeDepth(tex2D(_ObjectDepthTexture, screenCoords).r);
                float entityDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(IN.screenPos)).r);
				float actualDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(IN.screenPos)).r);
				
				float4 entityColor = tex2D(_ObjectIDTexture, screenCoords);

              // return entityColor;

    
   bool shouldSkip = (length(entityColor.xyz) < 0.01) ||
                      (entityDepth < _MinimumRange) ||
                      (entityDepth > _MaximumRange + _RangeFalloff);

    if (shouldSkip) {
        return primaryColor;

    }
        
    							
				float3 surfaceNormal = (entityColor.yzw) * 2.0 - 1.0;
            	float blendingScale = _BlendingRadius / (entityDepth * _ScalingFactor);
             	bool hasNearbySeam = false;

      static const float2 quickOffsets[8] = {
        float2(1, 0), float2(-1, 0), float2(0, 1), float2(0, -1), float2(1, 1), float2(-1, -1), float2(1, -1), float2(-1, 1)
    };

    [unroll(4)]
    for(int i = 0; i < 4; i++) {
        float2 quickOffset = quickOffsets[i] * blendingScale;
       float4 quickID = tex2D(_ObjectIDTexture, screenCoords + quickOffset);
        hasNearbySeam = hasNearbySeam || (abs(quickID.x - entityColor.x) > _EntityTolerance);
    }
     

    float2 closestSeamLocation = float2(0.0, 0.0);

        closestSeamLocation = hasNearbySeam ?
            FindClosestSeam(screenCoords, entityColor, surfaceNormal, blendingScale) :
            float2(0.0, 0.0);

				float minimumDistance = dot(closestSeamLocation, closestSeamLocation);


                float4 neighborColor = tex2D(_MainTex, screenCoords + closestSeamLocation*2);
			   // float neighborDepth = LinearEyeDepth(tex2D(_ObjectDepthTexture, screenCoords + closestSeamLocation*2).r);
               float neighborDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(IN.screenPos + float4(closestSeamLocation*2,0,0))).r);
        
				float depthVariance = abs(neighborDepth-entityDepth);
				float maxFalloffDistance = _RangeFalloff;
				float spatialWeight = saturate(0.5 - sqrt(minimumDistance) / maxFalloffDistance);
				float depthWeight = saturate(1.0 - depthVariance / (_DistanceFade*_BlendingRadius));
				float compositeWeight = spatialWeight * depthWeight;
				if (entityDepth > _MaximumRange) {
					compositeWeight *= 1-saturate((entityDepth-_MaximumRange)/_RangeFalloff);
				}
				if (entityDepth < _MinimumRange) {
					compositeWeight *= 1-saturate((_MinimumRange-entityDepth)/_RangeFalloff);
				}
                    
			    float3 neighborColorRGB = neighborColor.rgb;
			    float brightness = dot(neighborColorRGB, float3(0.299, 0.587, 0.114));
			    float3 enhancedColor = lerp(float3(brightness, brightness, brightness), neighborColorRGB, _ColorIntensity);
			    float4 adjustedNeighborColor = float4(enhancedColor, neighborColor.a);

			    float adjustedWeight = compositeWeight * _OpacityLevel;
                
			   return float4(lerp(primaryColor.rgb, adjustedNeighborColor.rgb, adjustedWeight), 1.0);
                      
             
            }
            ENDCG
        }
    }
}
