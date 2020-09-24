using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public GameObject character;
    public float speedH = 2.0f;
    public float speedV = 2.0f;

    private float yaw = 0.0f;
    private float pitch = 0.0f;

    
    ///////////////////////////////////////////////////////////////////// 

     /////////////////////////////////////////////////////////////////
    void Update () {

        if (Input.GetMouseButton(1)){
            yaw += speedH * Input.GetAxis("Mouse X");
            pitch -= speedV * Input.GetAxis("Mouse Y");

          
            transform.eulerAngles = new Vector3(character.transform.eulerAngles.x + 12f, yaw, 0.0f);
            character.transform.eulerAngles = new Vector3(0.0f, yaw, 0.0f);
            

        }
        else{
                yaw = character.transform.eulerAngles.y;
                pitch = character.transform.eulerAngles.x;
                transform.rotation = Quaternion.Euler(character.transform.eulerAngles.x + 12f, character.transform.eulerAngles.y, character.transform.eulerAngles.z);


        }
    }

}
