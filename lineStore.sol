
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract lineStore {
    // Contract can have an instance variables.
    // In this example instance variable `timestamp` is used to store the time of `constructor` or `touch`
    // function call
    uint32 public timestamp;
    string[] line;
    uint endQueue=0;
    

    // Contract can have a `constructor` – function that will be called when contract will be deployed to the blockchain.
    // In this example constructor adds current time to the instance variable.
    // All contracts need call tvm.accept(); for succeeded deploy
    constructor() public {
        // Check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and
        // message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        // The current smart contract agrees to buy some gas to finish the
        // current transaction. This actions required to process external
        // messages, which bring no value (henceno gas) with themselves.
        tvm.accept();

        timestamp = now;
    }

    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}


    function addToLine (string peopleName) public checkOwnerAndAccept {
        if (line.length<=endQueue)
         line.push(peopleName);
        else
         line[endQueue]=peopleName; 
         endQueue++;
    }
    function extractNext() public checkOwnerAndAccept{
        require(!(endQueue<=0),103, "Очередь пуста");
        for(uint256 i=0;i<line.length-1;i++)
        {
            line[i]=line[i+1];
        }
        //delete line[line.length-1];
        endQueue--;
    }


    

}
