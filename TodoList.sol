// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoList {
    struct Todo {
        string title;
        string description;
        bool doneStatus;
        address createdBy; 
    }

    // Array to store all Todo items
    Todo[] public todos;

    // Mapping to store the index of each Todo item in the array
    mapping(uint256 => address) public todoIndexToCreator;

    // Event to log when a new Todo is created
    event TodoCreated(string title, string description, bool doneStatus, address createdBy);

    function createTodo(string memory _title, string memory _description) external {
        Todo memory newTodo = Todo({
            title: _title,
            description: _description,
            doneStatus: false,
            createdBy: msg.sender
        });
        // Adds the newly created newTodo to the end of the todos array. 
        // The todos array is used to store all the Todo items in the smart contract.
        todos.push(newTodo);

        // Log the creation of a new Todo
        emit TodoCreated(_title, _description, false, msg.sender);

        // Store the index of the Todo item along with the creator's address
        todoIndexToCreator[todos.length - 1] = msg.sender;
    }

    function getTodoCount() external view returns (uint256) {
        return todos.length;
    }

    function getTodoByIndex(uint256 index) external view returns (string memory, string memory, bool, address) {
        require(index < todos.length, "Index out of bounds");
        Todo storage todo = todos[index];
        return (todo.title, todo.description, todo.doneStatus, todo.createdBy);
    }
}
