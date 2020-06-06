## Script para criação dos certificados raiz autoassinado e cliente para VPN Ponto a Site (Point-to-Site VPN) no Azure. - Créditos Gabriel Luiz - www.gabrielluiz.com ##


# Criação do certificado raiz autoassinado.

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

# Criação do certificado de cliente.

New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature `
-Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")


# Abri o console de gerenciamento de certificados.

certmgr 

# Referência: https://docs.microsoft.com/pt-br/azure/vpn-gateway/vpn-gateway-certificates-point-to-site