using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PDController : MonoBehaviour
{
    public static float speed = 4;
   
    float gravity = 8;
    
    Vector3 moveDir = Vector3.zero;
    

    CharacterController controller;
   
    Animator anim;

    public static bool isRunning = false;

    public static bool isWalking = false;
    
    // Start is called before the first frame update
    void Start()
    {

        controller = GetComponent<CharacterController>();
        anim = GetComponent<Animator>();
        gameObject.tag = "Player";

    }

    // Update is called once per frame
    void Update()
    {
        GetInput();
        Movement();
        
        

    }
    void GetInput(){

        if (controller.isGrounded){
            /*
            if (Input.GetMouseButtonDown(0)){
                if (anim.GetBool("Walking")){
                    anim.SetBool("Walking", false);
                    anim.SetInteger("condition", 0);
                }
                if (!anim.GetBool("Walking")){
                    Attacking();
                }
            }
            */
            if (Input.GetKeyDown(KeyCode.Space) && !anim.GetBool("Walking")){

                Jumping();

            }else if(Input.GetKeyDown(KeyCode.Space) && anim.GetBool("Walking")){
                anim.SetBool("Walking", false);
                isWalking = anim.GetBool("Walking");
                anim.SetBool("Jumping", true);
                StartCoroutine(RunJump());
             
            }


        }
    }
    void Movement(){

        if(controller.isGrounded){

            if(Input.GetKey(KeyCode.W)){
                
                if(anim.GetBool("Attacking")){
                    anim.SetBool("Attacking", false);
                    return;
                }
                else if (!anim.GetBool("Attacking") && !anim.GetBool("Jumping")){
                    anim.SetBool("Walking", true);
                    isWalking = anim.GetBool("Walking");
                    anim.SetInteger("condition", 1);
                    moveDir = new Vector3 (0,0,1);
                    moveDir *=  speed;
                    moveDir = transform.TransformDirection(moveDir);
              
                }
            }
            if(Input.GetKeyUp(KeyCode.W)){
                anim.SetBool("Walking", false);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 0);
                moveDir = new Vector3 (0,0,0);
            
            }

            if (Input.GetKey(KeyCode.S)){
                
                anim.SetBool("Walking", true);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 4);
                moveDir = new Vector3(0,0,-1);
                moveDir *= (speed/2);
                moveDir = transform.TransformDirection(moveDir);
            }
            if(Input.GetKeyUp(KeyCode.S)){
                
                anim.SetBool("Walking", false);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 0);
                moveDir = new Vector3 (0,0,0);
            }
            if (Input.GetKey(KeyCode.D)){
                anim.SetBool("L/R", false);
                anim.SetBool("Walking", true);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 5);
                moveDir = new Vector3(1,0,0);
                moveDir *= (speed);
                moveDir = transform.TransformDirection(moveDir);
            }
            if(Input.GetKeyUp(KeyCode.D)){
                anim.SetBool("Walking", false);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 0);
                moveDir = new Vector3 (0,0,0);
            }
            if (Input.GetKey(KeyCode.A)){
                anim.SetBool("Walking", true);
                isWalking = anim.GetBool("Walking");
                anim.SetInteger("condition", 6);
                moveDir = new Vector3(-1,0,0);
                anim.SetBool("L/R", true);
                moveDir *= (speed);
                moveDir = transform.TransformDirection(moveDir);
            }
            if(Input.GetKeyUp(KeyCode.A)){
                anim.SetInteger("condition", 0);
                anim.SetBool("L/R", false);
                anim.SetBool("Walking", false);
                isWalking = anim.GetBool("Walking");
                moveDir = new Vector3 (0,0,0);
            }
            if (Input.GetKey(KeyCode.LeftShift) && Input.GetKey(KeyCode.W)){
                anim.SetBool("Walking", false);
                anim.SetBool("Running", true);
                isRunning = anim.GetBool("Running");
                anim.SetInteger("condition", 8);
                moveDir = new Vector3(0,0,1);
                moveDir *= speed*2f;
                moveDir = transform.TransformDirection(moveDir);
                isRunning = true;
            }
            if (Input.GetKeyUp(KeyCode.LeftShift) || Input.GetKeyUp(KeyCode.W)){
                anim.SetInteger("condition", 0);
                print("stopped");
                anim.SetBool("Running", false);
                isRunning = anim.GetBool("Running");
                anim.SetBool("Walking", false);
                moveDir = new Vector3 (0,0,0);
                isRunning = false;
            }



        }
        //rot += Input.GetAxis("Horizontal") * rotSpeed * Time.deltaTime;
        //transform.eulerAngles = new Vector3 (0,rot,0);

        moveDir.y -= gravity * Time.deltaTime;
        controller.Move(moveDir * Time.deltaTime);


    }

    void Jumping(){

        StartCoroutine(JumpingRoutine());  

    }


    void Attacking(){
    
       
        StartCoroutine(AttackRoutine());
   
    }


    IEnumerator JumpingRoutine(){
        anim.SetInteger("condition", 3);
        moveDir = new Vector3 (0,1,0);
        moveDir*= speed;
        moveDir = transform.TransformDirection(moveDir);
        yield return new WaitForSeconds(1f);
        anim.SetInteger("condition", 0);
      

    }


    IEnumerator AttackRoutine(){
        anim.SetBool("Attacking", true);
        anim.SetInteger("condition", 2);
        yield return new WaitForSeconds(0.5f);
        anim.SetInteger("condition", 0);
        anim.SetBool("Attacking", false);
    }

   IEnumerator RunJump(){
        
        anim.SetInteger("condition", 3);
        moveDir = new Vector3(0,1,1);
        moveDir *= speed*1.5f;
        moveDir = transform.TransformDirection(moveDir);
        yield return new WaitForSeconds(0.5f);
        moveDir = new Vector3 (0,0,0);
        anim.SetInteger("condition", 0);
        anim.SetBool("Jumping", false);


    }



}
