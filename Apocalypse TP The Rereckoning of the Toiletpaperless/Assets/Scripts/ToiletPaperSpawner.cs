using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToiletPaperSpawner : MonoBehaviour
{
    public GameObject tp;
    public GameObject golden;

    public static int tp_count;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(tp_spawn());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator tp_spawn(){
        tp_count = 0;
        while(true){
            
  
			int tp_max = 7;
            
            Vector3 local = new Vector3(Random.Range(0,35), 1.2f, Random.Range(0,35));
            if (!(tp_count == tp_max)){
                
                Collider[] hitColliders = new Collider[10];
                hitColliders = Physics.OverlapSphere(local, 1);
                if (hitColliders.Length == 0) {
                    Instantiate(tp, local, Quaternion.identity);
                    tp_count += 1;
                }

                
            }
			

			yield return new WaitForSeconds(Random.Range(1, 3));



        }
    }
}
