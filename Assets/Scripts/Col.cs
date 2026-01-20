using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Col : MonoBehaviour
{

     public UnityEvent Play;
     public Transform player;
     bool cdOFF = true;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        // :V
        if ((player.position - this.transform.position).sqrMagnitude <= 1 && cdOFF) {
            Play.Invoke();
            cdOFF = false;
            StartCoroutine(cd());
            
        }
    IEnumerator cd()
        {
            yield return new WaitForSecondsRealtime(2);
            cdOFF = true;
        }
    }   
}
