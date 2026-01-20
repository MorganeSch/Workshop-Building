using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(FullScreenRender), PostProcessEvent.BeforeStack, "Kimede/MeshBlendingStepTwo")]
public sealed class MeshBlendingStepTwo : PostProcessEffectSettings
{
    [Range(0, 8), Tooltip("Steps Quality (Performance)")]
    public IntParameter processingIterations = new IntParameter { value = 1 };
    [Range(0f, 2f), Tooltip("Blend Radius")]
    public FloatParameter blendingRadius = new FloatParameter { value = 0.1f };
    [Range(0f, 250f), Tooltip("Scaling Factor")]
    public FloatParameter scalingFactor = new FloatParameter { value = 50.0f };
    [Range(0f, 10), Tooltip("Distance Fade")]
    public FloatParameter DistanceFade = new FloatParameter { value = 2.0f };
    [Range(0f, 5f), Tooltip("Color Saturation")]
    public FloatParameter _ColorIntensity = new FloatParameter { value = 1.0f };
    [Range(0f, 5f), Tooltip("Blend Transparency")]
    public FloatParameter _OpacityLevel = new FloatParameter { value = 1.0f };
    [Range(0f, 2f), Tooltip("Surface Threshold")]
    public FloatParameter _SurfaceThreshold = new FloatParameter { value = 0.5f };
    [Range(-1f, 1f), Tooltip("Entity Tolerance")]
    public FloatParameter _EntityTolerance = new FloatParameter { value = 0.2f };
    [Range(0f, 20f), Tooltip("Min Active Distance")]
    public FloatParameter _MinimumRange = new FloatParameter { value = 0.1f };
    [Range(0f, 1000f), Tooltip("Max Active Distance")]
    public FloatParameter _MaximumRange = new FloatParameter { value = 100.0f };
    [Range(0f, 10f), Tooltip("Outside Active Distance")]
    public FloatParameter _RangeFalloff = new FloatParameter { value = 3.0f };

}

public sealed class FullScreenRender : PostProcessEffectRenderer<MeshBlendingStepTwo>
{
    RenderTexture tempCameraRT;
    Material material;
    Shader shader;

    public override void Init()
    {
        base.Init();
        shader = Shader.Find("Kimede/MeshBlendingBuiltin");
        if (shader != null)
        {
            material = new Material(shader);
            BlendDefaultSettings.ResetToDefault(material);

        }
    }
    public override void Render(PostProcessRenderContext context)
    {
        // If the shader/material wasn't found, fall back to a simple blit and skip custom processing.
        if (material == null)
        {
            context.command.Blit(context.source, context.destination);
            return;
        }

        if (IDGeneratorRenderer.tempColorRT != null)
            material.SetTexture("_ObjectIDTexture", IDGeneratorRenderer.tempColorRT);
        else
            material.SetTexture("_ObjectIDTexture", Texture2D.whiteTexture);

        if (IDGeneratorRenderer.tempDepthRT != null)
            material.SetTexture("_ObjectDepthTexture", IDGeneratorRenderer.tempDepthRT);
        else
            material.SetTexture("_ObjectDepthTexture", Texture2D.blackTexture);


        material.SetInt("_ProcessingIterations", settings.processingIterations);
        material.SetFloat("_BlendingRadius", settings.blendingRadius);
        material.SetFloat("_ScalingFactor", settings.scalingFactor);
        material.SetFloat("_DistanceFade", settings.DistanceFade);
        material.SetFloat("_ColorIntensity", settings._ColorIntensity);
        material.SetFloat("_OpacityLevel", settings._OpacityLevel);
        material.SetFloat("_SurfaceThreshold", settings._SurfaceThreshold);
        material.SetFloat("_EntityTolerance", settings._EntityTolerance);
        material.SetFloat("_MinimumRange", settings._MinimumRange);
        material.SetFloat("_MaximumRange", settings._MaximumRange);
        material.SetFloat("_RangeFalloff", settings._RangeFalloff);


        // Enable camera depth texture
        context.camera.depthTextureMode |= DepthTextureMode.Depth;

        if (tempCameraRT == null || tempCameraRT.width != context.width || tempCameraRT.height != context.height)
        {
            if (tempCameraRT != null)
                RenderTexture.ReleaseTemporary(tempCameraRT);
            tempCameraRT = RenderTexture.GetTemporary(context.width, context.height, 0, RenderTextureFormat.ARGB32);
        }

        context.command.Blit(context.source, tempCameraRT);
        material.SetTexture("_MainTex", tempCameraRT);
        context.command.Blit(context.source, context.destination, material, 0);

    }

    public override void Release()
    {
        if (tempCameraRT != null)
        {
            RenderTexture.ReleaseTemporary(tempCameraRT);
            tempCameraRT = null;
        }
        if (material != null)
        {
            UnityEngine.Object.DestroyImmediate(material);
            material = null;
        }

        if (shader != null)
        {
            shader = null;
        }

    }
}

public static class BlendDefaultSettings
{
    public static int ProcessingIterations = 1;
    public static int ScalingFactor = 50;
    public static float BlendingRadius = 0.1f;
    public static float DistanceFade = 0.5f;
    public static float MinimumRange = 0.1f;
    public static float MaximumRange = 100f;
    public static float RangeFalloff = 3f;
    public static float SurfaceThreshold = 0.5f;
    public static float ColorIntensity = 1f;
    public static float OpacityLevel = 1f;
    public static float EntityTolerance = 0.1f;
    public static bool isChanged = false;

    public static void ResetToDefault(Material material)
    {
        ProcessingIterations = material.GetInt("_ProcessingIterations");
        ScalingFactor = material.GetInt("_ScalingFactor");
        BlendingRadius = material.GetFloat("_BlendingRadius");
        DistanceFade = material.GetFloat("_DistanceFade");
        MinimumRange = material.GetFloat("_MinimumRange");
        MaximumRange = material.GetFloat("_MaximumRange");
        RangeFalloff = material.GetFloat("_RangeFalloff");
        SurfaceThreshold = material.GetFloat("_SurfaceThreshold");
        ColorIntensity = material.GetFloat("_ColorIntensity");
        OpacityLevel = material.GetFloat("_OpacityLevel");
        EntityTolerance = material.GetFloat("_EntityTolerance");
        isChanged = true;
    }

}
