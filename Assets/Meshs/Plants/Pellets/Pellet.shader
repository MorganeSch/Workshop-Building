// Made with Amplify Shader Editor v1.9.9.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Pellet"
{
	Properties
	{
		_re_no_tex01_ia4( "re_no_tex01_ia4", 2D ) = "white" {}
		_re_no_tex04_ia4( "re_no_tex04_ia4", 2D ) = "white" {}
		_RED( "RED", Float ) = 1
		_re_no_tex03_ia4( "re_no_tex03_ia4", 2D ) = "white" {}
		_BLUE( "BLUE", Float ) = 1
		_re_no_tex02_ia4( "re_no_tex02_ia4", 2D ) = "white" {}
		_Is1( "Is1", Int ) = 0
		_Is5( "Is5", Int ) = 0
		_Is10( "Is10", Int ) = 0
		_Is20( "Is20", Int ) = 0
		_Metal( "Metal", Range( 0, 1 ) ) = 0
		_Smooth( "Smooth", Range( 0, 1 ) ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#define ASE_VERSION 19905
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform int _Is1;
		uniform sampler2D _re_no_tex01_ia4;
		uniform int _Is5;
		uniform sampler2D _re_no_tex02_ia4;
		uniform int _Is10;
		uniform sampler2D _re_no_tex03_ia4;
		uniform int _Is20;
		uniform sampler2D _re_no_tex04_ia4;
		uniform float _RED;
		uniform float _BLUE;
		uniform float _Metal;
		uniform float _Smooth;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (2.0).xx;
			float2 uv_TexCoord69 = i.uv_texcoord * temp_cast_0;
			float2 break74 = uv_TexCoord69;
			float4 appendResult78 = (float4(( -0.5 + break74.x ) , ( break74.y + -0.5 ) , 0.0 , 0.0));
			float4 tex2DNode2 = tex2D( _re_no_tex01_ia4, appendResult78.xy );
			float4 tex2DNode112 = tex2D( _re_no_tex02_ia4, appendResult78.xy );
			float4 tex2DNode111 = tex2D( _re_no_tex03_ia4, appendResult78.xy );
			float4 tex2DNode109 = tex2D( _re_no_tex04_ia4, appendResult78.xy );
			float4 color121 = IsGammaSpace() ? float4( 1, 0, 0, 0 ) : float4( 1, 0, 0, 0 );
			float4 color117 = IsGammaSpace() ? float4( 1, 1, 0, 0 ) : float4( 1, 1, 0, 0 );
			float4 color118 = IsGammaSpace() ? float4( 0, 0, 1, 0 ) : float4( 0, 0, 1, 0 );
			float3 ifLocalVar122 = 0;
			if( _RED > _BLUE )
				ifLocalVar122 = color121.rgb;
			else if( _RED == _BLUE )
				ifLocalVar122 = color117.rgb;
			else if( _RED < _BLUE )
				ifLocalVar122 = color118.rgb;
			float4 lerpResult106 = lerp( ( ( 1 == _Is1 ? tex2DNode2 : float4( 0,0,0,0 ) ) + ( 1 == _Is5 ? tex2DNode112 : float4( 0,0,0,0 ) ) + ( 1 == _Is10 ? tex2DNode111 : float4( 0,0,0,0 ) ) + ( 1 == _Is20 ? tex2DNode109 : float4( 0,0,0,0 ) ) ) , float4( ifLocalVar122 , 0.0 ) , ( ( 1 == _Is1 ? ( 1.0 - tex2DNode2.a ) : 0.0 ) + ( 1 == _Is5 ? ( 1.0 - tex2DNode112.a ) : 0.0 ) + ( 1 == _Is10 ? ( 1.0 - tex2DNode111.a ) : 0.0 ) + ( 1 == _Is20 ? ( 1.0 - tex2DNode109.a ) : 0.0 ) ));
			o.Albedo = lerpResult106.rgb;
			o.Metallic = _Metal;
			o.Smoothness = _Smooth;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback Off
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19905
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;-2130,-18;Inherit;False;804;347;Center;8;69;70;74;75;76;72;71;78;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;70;-2080,112;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-1952,96;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-1760,112;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;75;-1824,48;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;76;-1824,192;Inherit;False;Constant;_Float2;Float 1;1;0;Create;True;0;0;0;False;0;False;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;72;-1664,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;71;-1664,32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;-1024,-624;Inherit;False;228;419;Selection/PseudoBool;5;126;149;150;148;140;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;78;-1504,112;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;-706,-66;Inherit;False;1140;739;Assembly;14;144;145;146;147;142;143;141;125;138;139;106;0;154;155;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;116;-1824,-1088;Inherit;False;756;880;color ;6;122;121;120;119;118;117;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;-1280,-176;Inherit;True;Property;_re_no_tex01_ia4;re_no_tex01_ia4;0;0;Create;True;0;0;0;False;0;False;-1;56eb08dcaba18c740bfce88460f767de;56eb08dcaba18c740bfce88460f767de;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;112;-1280,0;Inherit;True;Property;_re_no_tex02_ia4;re_no_tex02_ia4;5;0;Create;True;0;0;0;False;0;False;-1;760210870f74cbb4b96dbfd3ecbfba3e;760210870f74cbb4b96dbfd3ecbfba3e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;111;-1280,176;Inherit;True;Property;_re_no_tex03_ia4;re_no_tex03_ia4;3;0;Create;True;0;0;0;False;0;False;-1;f37c3803ce55f9d4e90a3cb9c47e8be5;f37c3803ce55f9d4e90a3cb9c47e8be5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;109;-1280,352;Inherit;True;Property;_re_no_tex04_ia4;re_no_tex04_ia4;1;0;Create;True;0;0;0;False;0;False;-1;ae4bbc0ea81153a4dbf03af59ca375ef;ae4bbc0ea81153a4dbf03af59ca375ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;126;-960,-512;Inherit;False;Property;_Is1;Is1;6;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;-960,-384;Inherit;False;Property;_Is10;Is10;8;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;-960,-320;Inherit;False;Property;_Is20;Is20;9;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;-960,-448;Inherit;False;Property;_Is5;Is5;7;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;140;-960,-576;Inherit;False;Constant;_True;True;6;0;Create;True;0;0;0;False;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;131;-992,-48;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;132;-992,128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;133;-992,304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;134;-992,480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;121;-1584,-784;Inherit;False;Constant;_Color3;Color 0;1;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;118;-1584,-432;Inherit;False;Constant;_Color2;Color 0;1;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;117;-1584,-608;Inherit;False;Constant;_Color1;Color 0;1;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;120;-1520,-848;Inherit;False;Property;_BLUE;BLUE;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;119;-1520,-912;Inherit;False;Property;_RED;RED;2;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;-656,240;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;-656,368;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;-656,112;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;-656,-16;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;142;-480,240;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;-480,368;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;141;-480,112;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;125;-480,-16;Inherit;False;0;4;0;INT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;122;-1280,-672;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;138;-320,144;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;-320,272;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;106;-192,176;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;155;-128,432;Inherit;False;Property;_Metal;Metal;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;154;-128,512;Inherit;False;Property;_Smooth;Smooth;11;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;160,176;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;Custom/Pellet;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;69;0;70;0
WireConnection;74;0;69;0
WireConnection;72;0;74;1
WireConnection;72;1;76;0
WireConnection;71;0;75;0
WireConnection;71;1;74;0
WireConnection;78;0;71;0
WireConnection;78;1;72;0
WireConnection;2;1;78;0
WireConnection;112;1;78;0
WireConnection;111;1;78;0
WireConnection;109;1;78;0
WireConnection;131;0;2;4
WireConnection;132;0;112;4
WireConnection;133;0;111;4
WireConnection;134;0;109;4
WireConnection;144;0;140;0
WireConnection;144;1;149;0
WireConnection;144;2;133;0
WireConnection;145;0;140;0
WireConnection;145;1;150;0
WireConnection;145;2;134;0
WireConnection;146;0;140;0
WireConnection;146;1;148;0
WireConnection;146;2;132;0
WireConnection;147;0;140;0
WireConnection;147;1;126;0
WireConnection;147;2;131;0
WireConnection;142;0;140;0
WireConnection;142;1;149;0
WireConnection;142;2;111;0
WireConnection;143;0;140;0
WireConnection;143;1;150;0
WireConnection;143;2;109;0
WireConnection;141;0;140;0
WireConnection;141;1;148;0
WireConnection;141;2;112;0
WireConnection;125;0;140;0
WireConnection;125;1;126;0
WireConnection;125;2;2;0
WireConnection;122;0;119;0
WireConnection;122;1;120;0
WireConnection;122;2;121;5
WireConnection;122;3;117;5
WireConnection;122;4;118;5
WireConnection;138;0;125;0
WireConnection;138;1;141;0
WireConnection;138;2;142;0
WireConnection;138;3;143;0
WireConnection;139;0;147;0
WireConnection;139;1;146;0
WireConnection;139;2;144;0
WireConnection;139;3;145;0
WireConnection;106;0;138;0
WireConnection;106;1;122;0
WireConnection;106;2;139;0
WireConnection;0;0;106;0
WireConnection;0;3;155;0
WireConnection;0;4;154;0
ASEEND*/
//CHKSM=F6F89AD2BD77AB852D28C49D0313B729ECE27888