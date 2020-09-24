using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shelfspawner : MonoBehaviour
{
    public GameObject big_shelf;
    public GameObject short_shelf;
    public GameObject Box1;
    public GameObject Box2;
    public GameObject Box3;
    public GameObject crate1;
    public GameObject crate2;
    public GameObject character;
    // Start is called before the first frame update
    void Start()
    {
        int max_shelf = 150;
        int max_deco = 20;
        int self_type;
        int max_width = 37;
        int shelf_count = 0;
        bool character_placed = false;
        int maxcol = 30;
        /*
        for (int z = 5; z < max_width-2; z++){
            for (int x=2; x < max_width-5; x++){
                int wall = Random.Range(1,3);
                if (character_placed && shelf_count <= max_shelf){


                    self_type = Random.Range(1,3);

                    if (self_type == 1){
                        Collider[] hitColliders = new Collider[maxcol];
                        int checkResult = Physics.OverlapSphereNonAlloc( new Vector3(x,0,z), 20, hitColliders);
                        if (hitColliders.Length<= maxcol) {
                            Instantiate(big_shelf, new Vector3(x, 0, z), Quaternion.identity);
                            shelf_count += 1;
                        }

                    }
                    else if (self_type == 2){
                        Collider[] hitColliders = new Collider[maxcol];
                        int checkResult = Physics.OverlapSphereNonAlloc( new Vector3(x,0,z), 20, hitColliders);
                        if (hitColliders.Length <= maxcol) {
                            Instantiate(short_shelf, new Vector3(x, 0, z), Quaternion.identity);
                            shelf_count += 1;
                        }
                    }

                    
                    
  
                    
                }
                else if (!character_placed){
                    character.transform.SetPositionAndRotation(new Vector3(Random.Range(0,30), 1, Random.Range(0,30)), Quaternion.identity);

					
					character_placed = true;
                }
            }

        }
*/


        for (int x=0; x<max_shelf; x++){
            Vector3 local = new Vector3(Random.Range(2,35), 2, Random.Range(2,35));
            if (character_placed && shelf_count <= max_shelf){


                self_type = Random.Range(1,3);
              
                if (self_type == 1){
                    Collider[] hitColliders = new Collider[maxcol];
                    hitColliders = Physics.OverlapSphere(local, 1);
                    if (hitColliders.Length == 0) {
                        Instantiate(big_shelf, new Vector3(local.x, 0.2f, local.z), Quaternion.identity);
                        shelf_count += 1;
                    }

                }
                else if (self_type == 2){
                    Collider[] hitColliders = new Collider[maxcol];
                    hitColliders = Physics.OverlapSphere(local, 1);
                    if (hitColliders.Length == 0) {
                        Instantiate(short_shelf, new Vector3(local.x, 0.2f, local.z), Quaternion.identity);
                        shelf_count += 1;
                    }
                }
    
            }
            else if (!character_placed){
                Instantiate(character, local, Quaternion.identity);
                //character.transform.SetPositionAndRotation(new Vector3(Random.Range(0,30), 1, Random.Range(0,30)), Quaternion.identity);

                
                character_placed = true;
            }
            
        }

        List<GameObject> deco = new List<GameObject>();
        deco.Add(Box1);
        deco.Add(Box2);
        deco.Add(Box3);
        deco.Add(crate1);
        deco.Add(crate2);

        for (int x = 0; x< max_deco; x++){
            
            self_type = Random.Range(1,2);

            if (self_type == 1){

                Instantiate(deco[Random.Range(1,5)], new Vector3(Random.Range(0,30), 0, Random.Range(0,30)), Quaternion.identity);

            }


        }

    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
