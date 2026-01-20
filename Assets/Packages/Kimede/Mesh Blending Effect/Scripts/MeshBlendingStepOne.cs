using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(IDGeneratorRenderer), PostProcessEvent.BeforeTransparent, "Kimede/MeshBlendingStepOne")]

public sealed class MeshBlendingStepOne : PostProcessEffectSettings
{
 
    [Tooltip("Layer mask to filter objects for rendering")]
    // Use a ParameterOverride so the layer mask shows up in the PostProcess inspector
    public LayerMaskParameter layerMask = new LayerMaskParameter { value = new LayerMask { value = 1 } }; // Default layer (layer 0)

}



[Serializable]
public sealed class LayerMaskParameter : ParameterOverride<LayerMask>
{
}

public sealed class IDGeneratorRenderer : PostProcessEffectRenderer<MeshBlendingStepOne>
{
    public static RenderTexture tempColorRT;
    public static RenderTexture tempDepthRT;
    Shader customShader;
    Material customMaterial;
    Renderer[] renderers;
    Camera camera;
    CommandBuffer cmd;
    GameObject cameraHolder;

    public override void Init()
    {
        base.Init();
        customShader = Shader.Find("Kimede/IDGeneratorShader");
        if (customShader != null)
        {
            customMaterial = new Material(customShader);
        }

        var obj = GameObject.Find("MeshBlendCamera");
        if (obj != null)
        {
            cameraHolder = obj;
            camera = cameraHolder.GetComponent<Camera>();
            if (camera == null)
            {
                camera = cameraHolder.AddComponent<Camera>();
            }
            return;
        }
        else
        {
            cameraHolder = new GameObject("MeshBlendCamera");
            camera = cameraHolder.AddComponent<Camera>();
        }

    }


    public override void Render(PostProcessRenderContext context)
    {

        if (cameraHolder == null)
        {
            cameraHolder = new GameObject("MeshBlendCamera");
            camera = cameraHolder.AddComponent<Camera>();
        }

        EnsureRenderTextures(context);
            cmd = context.command;
            cameraHolder.transform.position = context.camera.transform.position;
            cameraHolder.transform.rotation = context.camera.transform.rotation;
            camera.CopyFrom(context.camera);
            camera.cullingMask = settings.layerMask.value.value;
            camera.targetTexture = tempColorRT;
            camera.enabled = false;
            camera.RenderWithShader(customShader, "RenderType");
        
        // Debug: Clear with red to see if render texture is being created
        /*
        cmd.SetRenderTarget(tempColorRT, tempDepthRT);
        cmd.ClearRenderTarget(true, true, Color.black);

        var prevCameraCullingMask = camera.cullingMask;
        var prevCameraTargetTexture = camera.targetTexture;

        // Only render if layerMask is not 0 (empty)
        if (settings.layerMask.value.value != 0)
        {
            camera.cullingMask = settings.layerMask.value.value;
            camera.targetTexture = tempColorRT;

            cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);

            if (customMaterial != null)
            {
                renderers = GameObject.FindObjectsByType<Renderer>(FindObjectsSortMode.None);
                int renderCount = 0;

                foreach (var renderer in renderers)
                {
                    if (((1 << renderer.gameObject.layer) & settings.layerMask.value.value) != 0)
                    {
                        for (int i = 0; i < renderer.sharedMaterials.Length; i++)
                        {
                            cmd.DrawRenderer(renderer, customMaterial);
                            renderCount++;
                        }
                    }
                }

            }
        }

        camera.cullingMask = prevCameraCullingMask;
        camera.targetTexture = prevCameraTargetTexture;
        */
                

    }

    private void EnsureRenderTextures(PostProcessRenderContext context)
    {
        int width = context.width;
        int height = context.height;

        if (tempColorRT == null || tempColorRT.width != width || tempColorRT.height != height)
        {
            if (tempColorRT != null) RenderTexture.ReleaseTemporary(tempColorRT);
            tempColorRT = RenderTexture.GetTemporary(width, height, 0, RenderTextureFormat.ARGB32);
        }

        if (tempDepthRT == null || tempDepthRT.width != width || tempDepthRT.height != height)
        {
            if (tempDepthRT != null) RenderTexture.ReleaseTemporary(tempDepthRT);
            tempDepthRT = RenderTexture.GetTemporary(width, height, 24, RenderTextureFormat.Depth);
        }
    }

    public override void Release()
    {
        if (tempColorRT != null)
        {
            RenderTexture.ReleaseTemporary(tempColorRT);
            tempColorRT = null;
        }

        if (tempDepthRT != null)
        {
            RenderTexture.ReleaseTemporary(tempDepthRT);
            tempDepthRT = null;
        }
    }
}
