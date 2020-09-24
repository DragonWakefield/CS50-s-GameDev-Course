using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
public class PD_Collisions : MonoBehaviour
{


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    void OnControllerColliderHit(ControllerColliderHit pickup) {
		if (pickup.gameObject.tag == "TP") {
            
			score_keeper.score += 1;
            score_keeper.total_score += 1;
            ToiletPaperSpawner.tp_count -= 1;	
            Destroy(pickup.gameObject);
			print (score_keeper.total_score);
            if (score_keeper.total_score % 5 == 0){
                int i = 0;
                var zomnav = FindObjectsOfType<NavMeshAgent>();
                while (i< zomnav.Length){
                    zomnav[i].speed += (0.5f * score_keeper.score/5);
                    i++;
                }
                
            }
         
		}

	}

}
