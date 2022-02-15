Shader "Custom/Rim"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white"{}
        _BumpMap("NormalMap", 2D) = "white"{}
        _LineCount("LineCount", Range(1, 10)) = 1
        _LineSpeed("LineSpeed", Range(0.1, 10)) = 1
        _AlphaAddValue("AlphaAddValue", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:blend
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _LineCount;
        float _LineSpeed;
        float _AlphaAddValue;
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            //o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            
            float rim = saturate(dot(o.Normal, IN.viewDir));
            float add1 = pow(frac(IN.worldPos.g * _LineCount + -_Time.y * _LineSpeed), 10);
            float add2 = pow(frac(IN.worldPos.r * _LineCount + -_Time.y * _LineSpeed), 10);
            rim = pow(1 - rim, 3) + (add1 + add2) * 0.3;
            o.Alpha = rim + _AlphaAddValue;
        }


        ENDCG
    }
    FallBack "Diffuse"
}
