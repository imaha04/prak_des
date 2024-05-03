pragma solidity ^0.8.0;

contract ServiceMarketplace {
    address payable public seller;
    address public buyer;
    uint public price;
    bool public fileSent;

    constructor() {
        seller = payable(msg.sender);
        fileSent = false;
    }

    function setBuyer(address _buyer) public {
        require(msg.sender == seller, "Only seller can set the buyer.");
        buyer = _buyer;
    }

    function setPrice(uint _price) public {
        require(msg.sender == seller, "Only seller can set the price.");
        price = _price;
    }

    function pay() payable public {
        require(msg.sender == buyer, "Only buyer can pay.");
        require(msg.value == price, "Incorrect amount transferred.");
    }

    function sendFile() public {
        require(msg.sender == seller, "Only seller can send the file.");
        require(address(this).balance == price, "Payment must be received before sending the file.");
        fileSent = true;
    }

    function releaseFunds() public {
        require(fileSent, "File must be sent before releasing funds.");
        seller.transfer(address(this).balance);
    }
}
