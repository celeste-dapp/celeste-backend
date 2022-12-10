# Celeste Technical Paper

## Smart Contract Map

-   CelesteLinkProxy
    -   CelesteLink owns:
        -   CelesteToken (ERC-20)
    -   CelesteLink has access to:
        -   CelestePost (ERC-721)
-   CelesteTokenProxy
    -   CelesteToken (ERC-20)
-   CelestePostProxy
    -   CelestePost (ERC-721)
-   CelesteUserProxy
    -   CelesteUser owns:
        -   CelestePost (ERC-721) owns:
            -   Celeste Token (ERC-20)
-   CelesteStakeProxy
    -   CelesteStake holds:
        -   CelestePost (ERC-721)
    -   CelesteStake rewards:
        -   CelesteUser, CelesteToken (ERC-20)

## What does each contract do?

### CelesteLink

CelesteLink is responsible for determining the value of a CelestePost based on the CelestePost's engagement, fed to the CelestePost by the application itself in functions defined in the CelestePost. CelesteLink is then responsible for distributing CelesteTokens between CelestePosts based on the value determined based on an algorithm where the value is equal to the (score / total score) \* tokens in circulation.

The CelesteLink mints these tokens and sends them directly to the CelestePost contract. The effects of this continual minting will be counteracted by burning tokens from every transaction.

### CelesteToken (CST)

CelesteTokens are ERC-20 tokens used to "pay" posts. They can be minted only by the CelesteLink and are burnt in every transaction (burn amount to be determined). CelesteTokens can be held by CelesteUsers and CelestePosts, as well as the CelesteLink.

CelesteTokens which are stored in CelestePosts can also be staked by CelesteUsers, which then earn rewards in the form of CelesteTokens.

### CelestePost

CelestePosts are ERC-721 NFTs which link to JSON on IPFS which stores the image/video, the content of the post, the address of the original owner, comments, likes, and boosts.

The CelestPost contract itself has two CelesteToken balances, available, and earning (locked). Earning funds are not available to be withdrawn as they are staked by the user to earn rewards in the CelesteStake contract. Available funds are given to the CelestePost by the CelesteLink.

### CelesteStake

CelesteStake is a contract which holds NFTs for a period of time determined by the user when deciding to stake their post. The rewards are determined by a function of the time they have decided to stake their post for and the determined value of the post givien by the CelesteLink.

## Required functions (Pseudocode)

### CelesteLink

```solidity
function scoreOfPost(postAddress) public view returns(uint256) {
  engagementData = postAddress.getEngagementData();
  score = (engagementData.boostCount * boostWeight) + (engagementData.likeCount * likeWeight) + (engagementData.commentCount * commentWeight);
  updateTotalScore(score);
  return score;
}

function getValue(postAddress) public view returns(uint256) {
  score = scoreOfPost(postAddress);
  totalScore = getTotalScore();
  value = (score / totalScore) * this.celesteTokens;
  return value;
}

function distributeValue(postAddress) private onlyOwner {
  value = getValue(postAddress);
  mint(postAddress,value);
}
```

### CelesteToken (Inherits from OpenZeppelin's ERC-20)

```solidity
function transfer(address _to, uint256 _value) public override returns (bool) {
  burn(msg.sender, (value * s_burn) / 100);
  _transfer(msg.sender, owner(), (_value * s_fee) / 100);
  _transfer(msg.sender, _to, (_value * (100 - s_fee - s_burn)) / 100);
  return true;
}
```

### CelestePost (Inherits from OpenZeppelin's ERC-721)

```solidity
//TBD
```

### CelesteStake

```solidity
struct Staker {
  tokenIds;
  tokenStakingCoolDown;
  balance;
  rewardsReleased;
}

mapping(address => Staker) public stakers;
mapping(uint256 => address) public tokenOwner;
bool public tokensClaimable;
bool initialised;

function stake(tokenId) public {
  _stake(msg.sender, tokenId)
}

function stakeBatch(tokenIds) public {
  for (i = 0; i < tokenIds.length; i++) {
    _stake(msg.sender), tokenIds[i]);
  }
}

function _stake(user, tokenId) {
  require(initialized);
  require(nft.ownerOf(_tokenId) == user);
  Staker staker = stakers[user]
}
```
