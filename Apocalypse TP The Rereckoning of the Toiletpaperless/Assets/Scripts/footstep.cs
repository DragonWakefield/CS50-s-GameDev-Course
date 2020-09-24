using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class footstep : MonoBehaviour
{
    // Start is called before the first frame update
    CharacterController plague;
    void Start()
    {
        plague = GetComponent<CharacterController>();   
    }

    // Update is called once per frame
    void Update()
    {
        if (plague.isGrounded && PDController.isWalking && GetComponent<AudioSource>().isPlaying == false){
            GetComponent<AudioSource>().Play();
            if (PDController.speed == (PDController.speed/2)){
                GetComponent<AudioSource>().pitch = 0.4f;
            }
            else if (PDController.isRunning){
                GetComponent<AudioSource>().pitch = 1.6f;
            }
            else{
                            
                GetComponent<AudioSource>().pitch = 0.8f;
       
            }
        }
    }
}
