contract Faucet {
    function withdraw(uint withdraw_amout) public {
        require(withdraw_amout <= 100000000000000000);
        msg.sender.transfer(withdraw_amout);
    }
    function () external payable {}
}