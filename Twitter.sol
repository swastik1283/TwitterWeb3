//SPDX-License-Identifier:MIT 
pragma solidity ^0.8.26;
contract Twitter{
    //define  structs


  uint16 public MAX_TWEET_LENGTH=280;

    struct Tweet{ 
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    } 
     

     // adding tweets ,mapping to the user,retrieving 1 tweet,retrieving many tweets 
    mapping(address => Tweet[]) public  tweets;
    address public owner;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"you are not owner");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
            MAX_TWEET_LENGTH=newTweetLength;
    }

    function createTweet(string memory _tweets) public{
        require (bytes(_tweets).length<=MAX_TWEET_LENGTH,"no longer than 280 char allowed");
        Tweet memory newTweet=Tweet({
            id:tweets[msg.sender].length,
            author:msg.sender,
            content:_tweets,
            timestamp:block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
    } 
   function likeTweet(address author,uint256 id )external{
    
       require(tweets[author][id].id==id,"tweets doesnt exist");

          tweets[author][id].likes++;

   }
   function unlikeTweet(address author,uint256 id) external{
    require(tweets[author][id].id==id,"tweets doesnt exist");
    require(tweets[author][id].likes>0,"tweets has no like");

    tweets[author][id].likes--;
   }

    function getTweet(uint _i)public  view returns (Tweet memory){
       return  tweets[msg.sender][_i];
    }
    function getallTweets(address _owner)public view returns(Tweet[] memory){
        return tweets[_owner];
    }
} 
