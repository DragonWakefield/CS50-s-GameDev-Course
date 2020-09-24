using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Zombiescript : MonoBehaviour
{

    public NavMeshAgent zom;

    public CharacterController plagueman;

    public float zomDistancerun = 10f;

    public Animator anim;
    
    public AudioSource zomNoise;
    public ArrayList zomTimes = new ArrayList();

    public bool growled = false;
    void Start () 
    {
        gameObject.tag = "zombie";
        anim = GetComponent<Animator>();  
        zom = GetComponent<NavMeshAgent>();
        //plagueman =  GameObject.Find("/Character Plague Doctor/PlagueMan");
        plagueman = FindObjectOfType<CharacterController>();
        zomNoise = GetComponent<AudioSource>();
        
        zomTimes.Add(1f);
        zomTimes.Add(5f);
        zomTimes.Add(10f);
        zomTimes.Add(14f);
        zomTimes.Add(17f);
        
        StartCoroutine(growl());

    }
    
    void Update () 
    {
        if (PDController.isRunning){
            zomDistancerun = 37f;
        }
        else{
            zomDistancerun = 10f;
        }

        float distance = Vector3.Distance(transform.position, plagueman.transform.position);

        if (distance < zomDistancerun){

            Vector3 getPlague = transform.position - plagueman.transform.position;
            Vector3 newPos = transform.position - getPlague;

            zom.SetDestination(newPos);

        }

        if (Mathf.Abs(distance) < 4f){
 
            anim.SetInteger("hit", 1);
            if (!growled){
                StartCoroutine(growl());
            }


        }
        else{
    
            anim.SetInteger("hit", 0);
        }


    }
    void OnTriggerEnter(Collider col){
        if(col.gameObject.tag == "Player"){
            if (score_keeper.score >= 5){
                score_keeper.score -= 5;
            }
            else{
                score_keeper.score = 0;
                print("game over");
            }
        }
    }

    IEnumerator growl(){
        int randSound = Random.Range(0,4);
        growled = true;
        zomNoise.time = (float) zomTimes[randSound];
        float maxTime = (float) zomTimes[randSound] + 2f;
        zomNoise.Play();
        yield return new WaitForSeconds(2.5f);
        zomNoise.Stop();
        growled = false;
    }


}
