using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZombieSpawner : MonoBehaviour
{
    public GameObject Zombie;
    public static int zombie_counter = 0;
    // Start is called before the first frame update
    void Start()
    {
        zombie_counter = 0;
        StartCoroutine(zombspawn());
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    IEnumerator zombspawn(){
        while(true){
            Instantiate(Zombie, new Vector3(Random.Range(0,30), 2, Random.Range(0,30)), Quaternion.identity);
            zombie_counter += 1;
            yield return new WaitForSeconds(10);
        }
    }
}
