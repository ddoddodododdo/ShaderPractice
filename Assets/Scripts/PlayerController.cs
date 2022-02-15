using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerController : MonoBehaviour
{
    public const float CAM_ROTATE_LIMIT = 80;

    public CharacterController controller;

    public float walkSpeed = 1;
    public float lookSensitivity;

    private float applySpeed;

    private const float SPEED_STANDARD = 0.02f;

    private Camera playerCam;

    private Vector3 moveHorizontal;
    private Vector3 moveVertical;
    private Vector3 moveDir;
    private Vector3 camApplyRotate;
    private Vector3 playerRotate;

    private Vector3 temp;

    void Awake()
    {
        Cursor.lockState = CursorLockMode.Locked;

        playerCam = Camera.main;

        camApplyRotate = playerCam.transform.localEulerAngles;
        playerRotate = transform.localEulerAngles;
        applySpeed = walkSpeed;

    }

    void FixedUpdate()
    {
        MovePos();
    }


    void Update()
    {
        


        ManageMove();
        controller.SimpleMove(Vector3.down * Time.deltaTime);
    }

    private void MovePos()
    {
        moveHorizontal = transform.right * Input.GetAxisRaw("Horizontal");
        moveVertical = transform.forward * Input.GetAxisRaw("Vertical");

        moveDir = (moveHorizontal + moveVertical).normalized * applySpeed * SPEED_STANDARD;

        controller.Move(moveDir);

    }


    #region 이동관련
    private void ManageMove()
    {
        RotateCamera();
        RotatePlayer();
    }



    private void RotatePlayer()
    {
        float addRotY = Input.GetAxisRaw("Mouse X") * lookSensitivity;

        playerRotate.y += addRotY;

        transform.localEulerAngles = playerRotate;

        if (Input.GetKey(KeyCode.LeftControl))
        {
            Debug.Log("좌컨트롤 누름");
            //temp = transform.localEulerAngles + Vector3.up;
            temp += Vector3.up;
            transform.localEulerAngles = temp;
        }

    }

    private void RotateCamera()
    {
        float addRotX = Input.GetAxisRaw("Mouse Y") * lookSensitivity;

        camApplyRotate.x -= addRotX;
        camApplyRotate.x = Mathf.Clamp(camApplyRotate.x, -CAM_ROTATE_LIMIT, CAM_ROTATE_LIMIT);

        playerCam.transform.localEulerAngles = camApplyRotate;


    }
    #endregion




}

