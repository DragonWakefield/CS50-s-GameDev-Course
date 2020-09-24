using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class danceordie : MonoBehaviour
{
    Animator anim;
    
    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
        int randomDance = Random.Range(0,4);
        Scene scene = SceneManager.GetActiveScene();
        if (scene.name == "GameOver"){
            anim.SetInteger("condition", 4);
        }
        else{
            anim.SetInteger("condition", randomDance);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
