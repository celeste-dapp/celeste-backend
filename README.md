# Celeste Technical Paper

## Smart Contract Map

-   CelesteManagerProxy
    -   CelesteManager owns:
        -   CelesteToken (ERC-20)
    -   CelesteManager has access to:
        -   CelestePost (ERC-721)
-   CelesteTokenProxy
    -   CelesteToken (ERC-20)
-   CelestePostProxy
    -   CelestePost (ERC-721)
-   CelesteUserProxy
    -   CelesteUser owns:
        -   CelestePost (ERC-721) owns:
            -   Celeste Token (ERC-20)

## What does each contract do?

### CelesteManager

CelesteManager is responsible for determining the value of a CelestePost based on the CelestePost's engagement, fed to the CelestePost by the application itself in functions defined in the CelestePost. CelesteManager is then responsible for distributing CelesteTokens between CelestePosts based on the value determined based on an algorithm where the value is equal to the (score / total score) \* tokens in circulation.

The CelesteManager mints these tokens and sends them directly to the CelestePost contract. The effects of this continual minting will be counteracted by burning tokens from every transaction.

### CelesteToken (CST)

CelesteTokens are ERC-20 tokens used to "pay" posts. They can be minted only by the CelesteManager and are burnt in every transaction (burn amount to be determined). CelesteTokens can be held by CelesteUsers and CelestePosts, as well as the CelesteManager.

CelesteTokens which are stored in CelestePosts can also be staked by CelesteUsers, which then earn rewards in the form of CelesteTokens.

### CelestePost

CelestePosts are ERC-721 NFTs which link to JSON on IPFS which stores the image/video, the content of the post, the address of the original owner, comments, likes, and boosts.

The CelestPost contract itself has two CelesteToken balances, available, and earning (locked). Earning funds are not available to be withdrawn as they are staked by the user to earn rewards. Available funds are given to the CelestePost by the CelesteManager.

## Required functions (Pseudocode)

### CelesteManager

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

### CelesteToken

```solidity

```

### CelestePost

```solidity

```
