Shader "Custom/Hexagon"
{
    Properties
    {
        _Radian("Radian", Range(0, 360)) = 0
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        cull off

        CGPROGRAM
        #pragma surface surf Lambert noambient
        #pragma target 3.0

        sampler2D _MainTex;
        float _Radian;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float2 uv = abs(IN.uv_MainTex - 0.5);
            float degree = UNITY_PI * 2 / 360;
            float radian = _Radian * degree;
            float hexa = dot(uv, normalize(float2(sqrt(3), 1)));
            hexa = max(hexa, uv.y);

            o.Emission = hexa;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
