Shader "Custom/PartialVisibilityShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PlaneY ("Plane Y Position", Float) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        float _PlaneY;

        struct Input
        {
            float3 worldPos;  // Position of the fragment in world space
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Sample the texture
            fixed4 c = tex2D(_MainTex, float2(0, 0));
            o.Albedo = c.rgb;

            // Clip (discard) the fragment if it is below the plane
            // IN.worldPos.y is the fragment's Y position in world space
            if (IN.worldPos.y < _PlaneY)
            {
                clip(-1);  // Discard fragment if below the plane
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
