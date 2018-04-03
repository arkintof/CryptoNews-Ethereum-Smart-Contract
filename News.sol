pragma solidity ~0.4.18;


contract News{
    
    //the owner of the contract to add User
    address owner;
    
    /*
    *uint ===> user id
    *uint ===> public key
    */
    
    mapping(uint32 => uint32) User;
    //variable meant for info
    struct news {
    bytes32[]  image1;
    bytes32[]  image2;
    bytes32[]  info1;
    bytes32[]  info2;
    }   
    
    news data;
    //constructor for initializing the user
    function News() public{
        owner = msg.sender;
    }
    
        
    //only the owner can create the User who can add the data to the blockchain
    function createUser(uint32 id,uint32 publicKey) public{
        if(msg.sender == owner && User[id] == 0){ 
        User[id] = publicKey;
        }
    }
    
    function simplifyPower(uint val,uint pk,uint n) public constant returns (uint){
        if(pk == 1){
          return val;
        }

        for(uint j = 1;j<(n);j++){
          if((val ** j ) >= n){
            uint pw = uint(pk/j);
            uint rem = pk%j;
            return ((simplifyPower((val ** j) % n,pw,n) * ((val ** rem) % n)) % n);     

          }
          else{
            continue;
          }
        }
      }
      
     
    function verify(bytes32 data,uint[] Msg,uint[] cipherText,uint32 id,uint size,uint N) public returns(bool){
        uint32 publicKey = User[id];
        for(uint i=0;i<size;i++){
            if(simplifyPower(cipherText[i],publicKey,N) != Msg[i]){
                return false;
            }
        }
        //info.push(data);
        return true;
    }
    
    function insertNews(bytes32 img1,bytes32 img2,bytes32 Msg1,bytes32 Msg2) public{
        data.image1.push(img1);
        data.image2.push(img2);
        data.info1.push(Msg1);
        data.info2.push(Msg2);

    }
    
    function getNews() public constant returns(bytes32[],bytes32[],bytes32[],bytes32[]){
        return (data.image1,data.image2,data.info1,data.info2);
    }
    
    
}
