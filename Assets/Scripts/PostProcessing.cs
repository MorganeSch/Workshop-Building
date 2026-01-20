using System.Collections;
using System.Collections.Generic;
using System.Xml;
using UnityEngine;

namespace MaterialToCamera
{

    [ExecuteInEditMode]
    public class PostProcessing : MonoBehaviour
    {
        public Material material;

        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            Graphics.Blit(source, destination, material);
        }
    }
}
