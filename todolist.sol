// SPDX-Licensed-Verified : MIT

pragma solidity ^0.8.0 ; 

contract todolist {
    address public manager;
    constructor() public{
        manager = msg.sender; 
    }
    uint public num_task = 1; 
    struct Task{
        string todotask;
        bool status;
    }
    mapping (uint => Task) public todo;
    modifier onlyOwner(){
        require(
            manager == msg.sender
            ,
            "Only the owner is allowed to make changes"
        );
        _;
    }
    event taskcreation(
        string todotask,
        bool status
    );
    function createTask(string memory _todotask) public onlyOwner{
        todo[num_task] = Task(_todotask, false);
        num_task = num_task + 1;
        emit taskcreation(_todotask, false);
    }
    function completeTask(uint _num_task) public onlyOwner{
        todo[_num_task].status = true;
    }
    function viewTask(uint _id) public view returns(string memory){
        return todo[_id].todotask;
    }
/*    function viewTask(uint _id) public view returns(Task memory){
        return todo[_id];
        For future refrence: the above function will retrun a whole struct but in form of a tuple.
    }*/
}

