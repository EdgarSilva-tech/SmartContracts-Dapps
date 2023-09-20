// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract ToDo {
    address public admin;
    struct TaskList {
        string [] Task;
    }
    // mapping (address => ToDo) public List;
    mapping (address => bool) public Allowed;
    mapping (address => TaskList) Todo;
    TaskList tasklist;

    constructor() {
        admin = msg.sender;
        Allowed[admin] = true;
    }

    modifier CanSee(address viewer) {
        require(Allowed[viewer] = true, "Only users approved by the admin can see this tasklist");
        _;
    }

    modifier OnlyAdmin() {
        require(msg.sender == admin, "Only the Admin can call this function");
        _;
    }

    function CreateTask(string memory task) public OnlyAdmin {
        tasklist.Task.push(task);
        Todo[msg.sender] = tasklist;
    }

    function ShareTaskList(address user) public OnlyAdmin {
        Allowed[user] = true;
    }

    function ViewList() public CanSee(msg.sender) view returns(TaskList memory) {
        return Todo[admin];
    }
}
