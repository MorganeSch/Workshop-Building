Shader "Kimede/IDGeneratorShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        

            #include "UnityCG.cginc"

                CBUFFER_START(CameraFrustumCulling)
                float4 _CameraFrustumPlanes[6];
                CBUFFER_END

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            bool IsInCameraFrustum(float3 worldPos)
            {
                for(int i = 0; i < 6; i++)
                {
                    float dist = dot(_CameraFrustumPlanes[i].xyz, worldPos) + _CameraFrustumPlanes[i].w;
                    if(dist < 0.0)
                    {
                        return false;
                    }
                }
                return true;
            }

            struct v2f
            {
              
                float4 positionCS : SV_POSITION;
                float3 worldPos : TEXCOORD0;
			    float isCulled : TEXCOORD2;
			    float3 normalWS : TEXCOORD1;

            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.positionCS = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.normalWS = UnityObjectToWorldNormal(v.normal);

                 o.isCulled = IsInCameraFrustum(o.worldPos) ? 0.0 : 1.0;
              
                if(o.isCulled > 0.5)
                {
                    o.positionCS = float4(0, 0, 0, 0); 
                }
                
                return o;
            }

            float Hashrazer(float3 p)
            {
				p = p + float3(1.1723930,1.1723930,1.1723930);
                p = frac(p * 0.3183099 + 0.1);
                p *= 17.0;
                return frac(p.x * p.y * p.z * (p.x + p.y + p.z));
            }

            fixed4 frag (v2f input) : SV_Target
            {
              
                if(input.isCulled > 0.5)
                {
                   discard;
                }
                
                 
				float3 normal = normalize(input.normalWS);
       
                float3 objectPosition = input.positionCS.xyz;
        
				float hashrazer = Hashrazer(objectPosition);
        
                float3 encodedNormal = normal * 0.5 + 0.5;
           
				return fixed4(hashrazer, encodedNormal.x, encodedNormal.y, encodedNormal.z);

              
            }
            ENDCG
        }
    }
}
