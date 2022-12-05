// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";

/**
 * @title Doc ownership
 * @dev Set & change ownership of documents stored in Objkt
 */
contract DocOwnership is Owner {

    /**
 * @dev In the future ids are gonna be randomized
 */
    struct Document {
        uint id;
        string name;
        address[] trusted;
    }

    Document[] public documents;

    uint128 public documentCount = 0;

    mapping(address => uint[]) public ownerToItems;
    mapping(address => uint[]) public trustedToItems;

    function publishDocument(string memory _name, address[] memory _trusted) public isOwner {
        documents.push(Document(documentCount, _name, new address[](0)));
        ownerToItems[msg.sender].push(documentCount);
        documents[documentCount].trusted = _trusted;
        for (uint i = 0; i < _trusted.length; i++) {
            trustedToItems[_trusted[i]].push(documentCount);
        }
        documentCount++;
    }

    function _getOwnedDocs(address _user)internal view returns( Document[] memory){
        uint[] memory myDocs = ownerToItems[_user];
        Document[] memory result = new Document[](myDocs.length);
        for (uint i = 0; i < myDocs.length; i++) {
            result[i] = documents[myDocs[i]];
        }
        return result;
    }

    function _getTrustedDocs(address _user)internal view returns( Document[] memory){
        uint[] memory myDocs = trustedToItems[_user];
        Document[] memory result = new Document[](myDocs.length);
        for (uint i = 0; i < myDocs.length; i++) {
            result[i] = documents[myDocs[i]];
        }
        return result;
    }

    function getDocsForAddress(address _user)public view returns( Document[] memory, Document[] memory){
        return (_getTrustedDocs(_user), _getOwnedDocs(_user));
    }

}