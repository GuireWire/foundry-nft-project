// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    error BasicNft__TokenUriNotFound();
    //let's add token counter to represent each token id
    uint256 private s_tokenCounter;
    //this mapping will get a token Id and return a tokenURI
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {
        //we need this constructor as it's stated in the ERC721 contract
        s_tokenCounter = 0; //set to 0 then when we mint new dog, the storage variable gets updated
    }

    //function to mint a new dog
    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); //this came from the ERC721.sol
        s_tokenCounter = s_tokenCounter + 1;
    }

    //function tokenURI returns metadata json file of NFT
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert BasicNft__TokenUriNotFound();
        }
        return s_tokenIdToUri[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
