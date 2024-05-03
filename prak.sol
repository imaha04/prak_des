// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentExchange {
    mapping(address => mapping(address => string[])) private messages;
    mapping(address => mapping(address => string[])) private files;

    event MessageSent(address indexed sender, address indexed receiver, string message);
    event FileSent(address indexed sender, address indexed receiver, string fileContent);

    function sendMessage(address _receiver, string memory _message) public {
        messages[msg.sender][_receiver].push(_message);
        emit MessageSent(msg.sender, _receiver, _message);
    }

    function sendFile(address _receiver, string memory _fileContent) public {
        files[msg.sender][_receiver].push(_fileContent);
        emit FileSent(msg.sender, _receiver, _fileContent);
    }

    function getMessages(address _sender, address _receiver) public view returns (string[] memory) {
        return messages[_sender][_receiver];
    }

    function getFiles(address _sender, address _receiver) public view returns (string[] memory) {
        return files[_sender][_receiver];
    }
}
