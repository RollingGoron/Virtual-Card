//
//  CommunicationManager.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/22/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol CommunicationManagerDelegate {
  func connectionStatus(state : MCSessionState)
  func didReceiveCardData(cardModel : CardModel)
}

class CommunicationManager: NSObject {
  
  private let virtualCardService = "card-service"
  
  private let myPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
  
  
  private let serviceAdvertiser : MCNearbyServiceAdvertiser
  private let serviceBrowser : MCNearbyServiceBrowser
  
  lazy var session : MCSession = {
    let session = MCSession(peer: self.myPeerID, securityIdentity: nil, encryptionPreference: .Required)
    session.delegate = self
    return session
  }()
  
  var delegate : CommunicationManagerDelegate?
  
  override init() {
    self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: self.myPeerID, discoveryInfo: nil, serviceType: virtualCardService)
    self.serviceBrowser = MCNearbyServiceBrowser(peer: self.myPeerID, serviceType: virtualCardService)
    super.init()
    
    self.serviceAdvertiser.delegate = self;
    self.serviceBrowser.delegate = self
  }
  
  deinit {
    self.serviceBrowser.stopBrowsingForPeers()
    self.serviceAdvertiser.stopAdvertisingPeer()
  }
  
  func startDeviceScan() {
    print("Starting Advertising")
    self.serviceAdvertiser.startAdvertisingPeer()
    print("Starting browsing")
    self.serviceBrowser.startBrowsingForPeers()
  }
  
  func stopDeviceScan() {
    self.serviceBrowser.stopBrowsingForPeers()
    self.serviceAdvertiser.stopAdvertisingPeer()
  }
  
}

extension CommunicationManager : MCSessionDelegate {
  
  func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
    
  }
  
  func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
    print("Did receive data from peer")
    
    do {
      let modelData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! Dictionary<String, AnyObject>
      let cardModel = CardModel(dataModel: modelData)
      //Save to CoreData
      //Save to Network
      print("Received Card Model data! \(cardModel)")
      self.delegate?.didReceiveCardData(cardModel)
    } catch {
      print("An error occured when receiving data!")
    }
    
  }
  
  func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
    self.delegate?.connectionStatus(state)
  }
  
  func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
  }
  
  func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
    
  }
  
}

extension CommunicationManager : MCNearbyServiceAdvertiserDelegate {
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
    print("Advertiser \(advertiser) did not start advertising, with error \(error)")
  }
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
    print("Received inviation from \(peerID)")
    invitationHandler(true, self.session)
  }
  
}

extension CommunicationManager : MCNearbyServiceBrowserDelegate {
  
  func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
    
  }
  
  func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    print("Found peer \(peerID)")
    browser.invitePeer(peerID, toSession: self.session, withContext: nil, timeout: 10)
  }
  
  func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    print("Lost connection to peer \(peerID)")
  }
  
}

