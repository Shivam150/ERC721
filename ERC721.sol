
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

 interface Erc721
 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);
    
    function ownerOf(uint256 _tokenId) external view returns (address);

     
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external ;

    
    function transferFrom(address _from, address _to, uint256 _tokenId) external ;

    
    function approve(address _approved, uint256 _tokenId) external ;

     
    // function setApprovalForAll(address _operator, bool _approved) external;

     
    // function getApproved(uint256 _tokenId) external view returns (address);

     
    // function isApprovedForAll(address _owner, address _operator) external view returns (bool);

 }
 contract ERC721 is Erc721
{
    // uint NumberOfTokenId;
    string public  name ;
    string public Symbol ;

    mapping(uint  => address) private TokenOwner;
    mapping(address => uint) private tokenIds;
    mapping(address => mapping(address => uint)) public approval;
    constructor()
    {
         name = "Shiv";
         Symbol = "SHV";
    }

    function safeMint(address _owner,uint _tokenId) public returns(bool)
    {
        require(_owner != address(0),"Zero address");
        TokenOwner[_tokenId] = _owner;
        tokenIds[_owner] +=1;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256)
    {
        require(_owner != address(0),"zero address");
        return tokenIds[_owner];
    }

     
    
    function ownerOf(uint256 _tokenId) public view returns (address)
    {
        //require()
        address _owner = TokenOwner[_tokenId];
        require(_owner != address(0),"Zero address");
        return _owner;
    }

     
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external 
    {
        require(_to != address(0),"Zero address");
        require(msg.sender == _from,"authorization fails");
        require(tokenIds[_from] >0,"Insuficient balance");
        TokenOwner[_tokenId] = _to; 
        
        tokenIds[_to]++;
        tokenIds[_from]--;

    }

    
    function transferFrom(address _from, address _to, uint256 _tokenId) external 
    {
        require(_to != address(0),"Zero address");
        require(msg.sender == _from,"authorization fails");
        require(tokenIds[_from] >0,"Insuficient balance");
        
        TokenOwner[_tokenId] = _to; 
        tokenIds[_to]++;
        tokenIds[_from]--;

    }

    
    function approve(address _spender, uint256 _tokenId) external
    {
        address _owner = TokenOwner[_tokenId];
        require(msg.sender == _owner,"Owner authorized to approve");
        approval[msg.sender][_spender] = tokenIds[_owner];
    }

     
    // function setApprovalForAll(address _operator, bool _approved) external
    // {

    // }

     
    // function getApproved(uint256 _tokenId) external view returns (address)
    // {

    // }

     
    // function isApprovedForAll(address _owner, address _operator) external view returns (bool)
    // {

    // }
}
