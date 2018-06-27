//
//  ECDSAViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/6/27.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "ECDSAViewController.h"

@interface ECDSAViewController ()

@end

@implementation ECDSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self ECDSATest];
}

//CF_ENUM(OSStatus) {
//    errSSLProtocol              = -9800,    /* SSL protocol error */
//    errSSLNegotiation           = -9801,    /* Cipher Suite negotiation failure */
//    errSSLFatalAlert            = -9802,    /* Fatal alert */
//    errSSLWouldBlock            = -9803,    /* I/O would block (not fatal) */
//    errSSLSessionNotFound       = -9804,    /* attempt to restore an unknown session */
//    errSSLClosedGraceful        = -9805,    /* connection closed gracefully */
//    errSSLClosedAbort           = -9806,    /* connection closed via error */
//    errSSLXCertChainInvalid     = -9807,    /* invalid certificate chain */
//    errSSLBadCert               = -9808,    /* bad certificate format */
//    errSSLCrypto                = -9809,    /* underlying cryptographic error */
//    errSSLInternal              = -9810,    /* Internal error */
//    errSSLModuleAttach          = -9811,    /* module attach failure */
//    errSSLUnknownRootCert       = -9812,    /* valid cert chain, untrusted root */
//    errSSLNoRootCert            = -9813,    /* cert chain not verified by root */
//    errSSLCertExpired           = -9814,    /* chain had an expired cert */
//    errSSLCertNotYetValid       = -9815,    /* chain had a cert not yet valid */
//    errSSLClosedNoNotify        = -9816,    /* server closed session with no notification */
//    errSSLBufferOverflow        = -9817,    /* insufficient buffer provided */
//    errSSLBadCipherSuite        = -9818,    /* bad SSLCipherSuite */
//
//    /* fatal errors detected by peer */
//    errSSLPeerUnexpectedMsg     = -9819,    /* unexpected message received */
//    errSSLPeerBadRecordMac      = -9820,    /* bad MAC */
//    errSSLPeerDecryptionFail    = -9821,    /* decryption failed */
//    errSSLPeerRecordOverflow    = -9822,    /* record overflow */
//    errSSLPeerDecompressFail    = -9823,    /* decompression failure */
//    errSSLPeerHandshakeFail     = -9824,    /* handshake failure */
//    errSSLPeerBadCert           = -9825,    /* misc. bad certificate */
//    errSSLPeerUnsupportedCert   = -9826,    /* bad unsupported cert format */
//    errSSLPeerCertRevoked       = -9827,    /* certificate revoked */
//    errSSLPeerCertExpired       = -9828,    /* certificate expired */
//    errSSLPeerCertUnknown       = -9829,    /* unknown certificate */
//    errSSLIllegalParam          = -9830,    /* illegal parameter */
//    errSSLPeerUnknownCA         = -9831,    /* unknown Cert Authority */
//    errSSLPeerAccessDenied      = -9832,    /* access denied */
//    errSSLPeerDecodeError       = -9833,    /* decoding error */
//    errSSLPeerDecryptError      = -9834,    /* decryption error */
//    errSSLPeerExportRestriction = -9835,    /* export restriction */
//    errSSLPeerProtocolVersion   = -9836,    /* bad protocol version */
//    errSSLPeerInsufficientSecurity = -9837, /* insufficient security */
//    errSSLPeerInternalError     = -9838,    /* internal error */
//    errSSLPeerUserCancelled     = -9839,    /* user canceled */
//    errSSLPeerNoRenegotiation   = -9840,    /* no renegotiation allowed */
//
//    /* non-fatal result codes */
//    errSSLPeerAuthCompleted     = -9841,    /* peer cert is valid, or was ignored if verification disabled */
//    errSSLClientCertRequested   = -9842,    /* server has requested a client cert */
//
//    /* more errors detected by us */
//    errSSLHostNameMismatch      = -9843,    /* peer host name mismatch */
//    errSSLConnectionRefused     = -9844,    /* peer dropped connection before responding */
//    errSSLDecryptionFail        = -9845,    /* decryption failure */
//    errSSLBadRecordMac          = -9846,    /* bad MAC */
//    errSSLRecordOverflow        = -9847,    /* record overflow */
//    errSSLBadConfiguration      = -9848,    /* configuration error */
//    errSSLUnexpectedRecord      = -9849,    /* unexpected (skipped) record in DTLS */
//    errSSLWeakPeerEphemeralDHKey = -9850,   /* weak ephemeral dh key  */
//
//    /* non-fatal result codes */
//    errSSLClientHelloReceived   = -9851,    /* SNI */
//    errSecSuccess                               = 0,       /* No error. */
//    errSecUnimplemented                         = -4,      /* Function or operation not implemented. */
//    errSecIO                                    = -36,     /*I/O error (bummers)*/
//    errSecOpWr                                  = -49,     /*file already open with with write permission*/
//    errSecParam                                 = -50,     /* One or more parameters passed to a function where not valid. */
//    errSecAllocate                              = -108,    /* Failed to allocate memory. */
//    errSecUserCanceled                          = -128,    /* User canceled the operation. */
//    errSecBadReq                                = -909,    /* Bad parameter or invalid state for operation. */
//    errSecInternalComponent                     = -2070,
//    errSecNotAvailable                          = -25291,  /* No keychain is available. You may need to restart your computer. */
//    errSecDuplicateItem                         = -25299,  /* The specified item already exists in the keychain. */
//    errSecItemNotFound                          = -25300,  /* The specified item could not be found in the keychain. */
//    errSecInteractionNotAllowed                 = -25308,  /* User interaction is not allowed. */
//    errSecDecode                                = -26275,  /* Unable to decode the provided data. */
//    errSecAuthFailed                            = -25293,  /* The user name or passphrase you entered is not correct. */
//};

- (void)ECDSATest{
    CFErrorRef error = NULL;
    if (@available(iOS 9.0, *)) {
        SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                        kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                        // kSecAccessControlTouchIDAny |
                                                                        kSecAccessControlPrivateKeyUsage, &error);
        
        // Create parameters dictionary for key generation.
        if (@available(iOS 10.0, *)) {
            NSDictionary *parameters = @{
                                         (id)kSecAttrTokenID: (id)kSecAttrTokenIDSecureEnclave,
                                         (id)kSecAttrKeyType: (id)kSecAttrKeyTypeECSECPrimeRandom,
                                         (id)kSecAttrKeySizeInBits: @256,
                                         (id)kSecAttrLabel: @"my-se-key",
                                         (id)kSecPrivateKeyAttrs: @{
                                                 (id)kSecAttrAccessControl: (__bridge_transfer id)sacObject,
                                                 (id)kSecAttrIsPermanent: @YES,
                                                 }
                                         };
            
            NSError *gen_error = nil;
            id privateKey = CFBridgingRelease(SecKeyCreateRandomKey((__bridge CFDictionaryRef)parameters, (void *)&gen_error));
            
            NSDictionary *params = @{
                                     
                                     (id)kSecClass: (id)kSecClassKey, (id)kSecAttrKeyType: (id)kSecAttrKeyTypeECSECPrimeRandom, (id)kSecAttrKeySizeInBits: @256, (id)kSecAttrLabel: @"my-se-key", (id)kSecReturnRef: @YES, (id)kSecUseOperationPrompt: @"Authenticate to sign data"
                                     
                                     };
            
            SecKeyRef keyRef = nil;
            OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)params, (CFTypeRef *)&keyRef);
            NSLog(@"=========status=====%d",status);
            
            NSError *error;
            NSData *dataToSign = [@"我是签名内容" dataUsingEncoding:NSUTF8StringEncoding];
            
            NSData *signature = CFBridgingRelease(SecKeyCreateSignature((SecKeyRef)privateKey, kSecKeyAlgorithmECDSASignatureMessageX962SHA256, (CFDataRef)dataToSign, (void *)&error));
            
            id publicKey = CFBridgingRelease(SecKeyCopyPublicKey((SecKeyRef)privateKey));
            
            Boolean verified = SecKeyVerifySignature((SecKeyRef)publicKey, kSecKeyAlgorithmECDSASignatureMessageX962SHA256, (CFDataRef)dataToSign, (CFDataRef)signature, (void *)&error);
            
            NSString *message;
            if (verified == 1) {
                message = [NSString stringWithFormat:@"signature:%@ verified:%@ error:%@", signature, @"验签成功", error];
                
            }else{
                message = [NSString stringWithFormat:@"signature:%@ verified:%@ error:%@", signature, @"验签失败", error];
                
            }
            
            NSLog(@"==============%@",message);
        } else {
            // Fallback on earlier versions
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
