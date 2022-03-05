Shader "Custom/ChangeTexture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _XCount("Texture Count", Range(1, 10)) = 1
        _Speed("Speed", Range(0.1, 10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        //cull off

        CGPROGRAM
        #pragma surface surf Lambert noambient 
        #pragma target 3.0


        sampler2D _MainTex;
        float _Speed;
        int _XCount;

        struct Input
        {
            float2 uv_MainTex;
        };



        void surf (Input IN, inout SurfaceOutput o)
        {
            float tile = floor(fmod(_Time.y * _Speed, _XCount));
            float uvX = (IN.uv_MainTex + tile) / _XCount;

            float2 uv = float2(uvX, IN.uv_MainTex.y);
            fixed4 c = tex2D (_MainTex, uv);
            o.Emission = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
