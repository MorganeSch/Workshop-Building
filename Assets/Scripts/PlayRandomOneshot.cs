using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class PlayRandomOneshot : MonoBehaviour
{
    public List<AudioClip> sounds;
    AudioSource source;
    public float rootPitch = 1;
    public bool risingPitch;
    void Start()
    {
        source = GetComponent<AudioSource>();
    }
    public void Play()
    {
        float pitchChange = Random.Range(-1, 2);
        if (!(pitchChange == 0)) pitchChange /= 10; 
            
        source.pitch = rootPitch + pitchChange;
        source.PlayOneShot(sounds[Random.Range(0, sounds.Count)]);
        if (risingPitch) rootPitch += 0.001f;
    }
}