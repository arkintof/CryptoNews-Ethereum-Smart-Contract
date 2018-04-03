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
    bytes32  image1;
    bytes32  image2;
    bytes32  info1;
    bytes32  info2;
    }   
    
    news[] data;
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
      
     
    function verify(bytes32 img1,bytes32 img2,bytes32 Msg1,bytes32 Msg2,uint[] Msg,uint[] cipherText,uint32 id,uint size,uint N) public returns(bool){
        uint32 publicKey = User[id];
        for(uint i=0;i<size;i++){
            if(simplifyPower(cipherText[i],publicKey,N) != Msg[i]){
                return false;
            }
        }
        insertNews(img1,img2,Msg1,Msg2);
        return true;
    }
    
    function insertNews(bytes32 img1,bytes32 img2,bytes32 Msg1,bytes32 Msg2) public{
        data.push(news(img1,img2,Msg1,Msg2));

    }
    
    function getNews() public constant returns(bytes32[],bytes32[],bytes32[],bytes32[]){
        bytes32[] memory img1 = new bytes32[](data.length);
        bytes32[] memory img2 = new bytes32[](data.length);
        bytes32[] memory Msg1 = new bytes32[](data.length);
        bytes32[] memory Msg2 = new bytes32[](data.length);
        
        for(uint i=0;i < data.length;i++){
            img1[i] = data[i].image1;
            img2[i] = data[i].image2;
            Msg1[i] = data[i].info1;
            Msg2[i] = data[i].info2;
        }
        return (img1,img2,Msg1,Msg2);
    }
    
    //specific news
    function oneNews(uint32 id) public constant returns(bytes32,bytes32,bytes32,bytes32){
        return (data[id].image1,data[id].image2,data[id].info1,data[id].info2);
    }
    
    
}
