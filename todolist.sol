// SPDX-Licensed-Verified : MIT

pragma solidity ^0.8.0 ; 

contract todolist{
    address public manager;
    uint i=1;

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

    function viewTaskFromitsId(uint _id) public view returns(string memory){
        if (_id<num_task){
            return todo[_id].todotask;
        }else{
            return "Enter a valid number";
        }
    }

/*  function viewTask(uint _id) public view returns(Task memory){
        return todo[_id];
        For future refrence: the above function will retrun a whole struct but in form of a tuple.
    }*/

    function viewTaskFromitsName(string memory _todo) public returns(uint){

        /*In solidity there is no such thing to compare strings and == operator is not compatible with strings.
        So if we want to compare two string what we can do is check there hash and if both the strings are equal there hash
        would also be equal*/
        //And kessak-256 is ethereum's native hasing algorithm

        while(i<=num_task-1){
            if(keccak256(abi.encodePacked(_todo)) == keccak256(abi.encodePacked(todo[i].todotask))){
                return i;
                break;
            }
            else{
                i=i+1;
            }
        }
    }
}
