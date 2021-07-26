# From arnold@f7.net  Wed Jun 15 08:25:21 2005
# Return-Path: <arnold@f7.net>
# Received: from localhost (skeeve [127.0.0.1])
# 	by skeeve.com (8.12.11/8.12.11) with ESMTP id j5F5P3VC014658
# 	for <arnold@localhost>; Wed, 15 Jun 2005 08:25:21 +0300
# Received: from pop.012.net.il [84.95.5.221]
# 	by localhost with POP3 (fetchmail-6.2.5)
# 	for arnold@localhost (single-drop); Wed, 15 Jun 2005 08:25:21 +0300 (IDT)
# Received: from mtain2.012.net.il ([10.220.5.4])
#  by i_mss3.012.net.il (HyperSendmail v2004.12)
#  with ESMTP id <0II300LQOPS7DA10@i_mss3.012.net.il> for arobbins@012.net.il;
#  Wed, 15 Jun 2005 04:07:19 +0300 (IDT)
# Received: from VSCAN1 ([10.220.20.1])
#  by i_mtain2.012.net.il (HyperSendmail v2004.12)
#  with ESMTP id <0II300ETQPS7IEZ4@i_mtain2.012.net.il> for arobbins@012.net.il
#  (ORCPT arobbins@012.net.il); Wed, 15 Jun 2005 04:07:19 +0300 (IDT)
# Received: from i_mtain2.012.net.il ([10.220.5.4])
#  by VSCAN1 with InterScan Messaging Security Suite; Wed,
#  15 Jun 2005 04:03:15 +0300
# Received: from f7.net ([209.61.216.22])
#  by i_mtain2.012.net.il (HyperSendmail v2004.12)
#  with ESMTP id <0II300H7VPS5P1O2@i_mtain2.012.net.il> for arobbins@012.net.il;
#  Wed, 15 Jun 2005 04:07:18 +0300 (IDT)
# Received: (from arnold@localhost)	by f7.net (8.11.7-20030920/8.11.7)
#  id j5F13DT21530	for arobbins@012.net.il; Tue, 14 Jun 2005 21:03:14 -0400
# Received: from fencepost.gnu.org (fencepost.gnu.org [199.232.76.164])
# 	by f7.net (8.11.7-20030920/8.11.7) with ESMTP id j5F136p21454	for
#  <arnold@skeeve.com>; Tue, 14 Jun 2005 21:03:06 -0400
# Received: from monty-python.gnu.org ([199.232.76.173])
# 	by fencepost.gnu.org with esmtp (Exim 4.34)
# 	id 1DiMJ6-0002fe-Av	for bug-gawk@gnu.org; Tue, 14 Jun 2005 21:03:04 -0400
# Received: from Debian-exim by monty-python.gnu.org with spam-scanned
#  (Exim 4.34)	id 1DiMIp-0003lM-I4	for bug-gawk@gnu.org; Tue,
#  14 Jun 2005 21:02:47 -0400
# Received: from [66.187.233.31] (helo=mx1.redhat.com)
# 	by monty-python.gnu.org with esmtp (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24)
# 	(Exim 4.34)	id 1DiMIp-0003l4-8g	for bug-gawk@gnu.org; Tue,
#  14 Jun 2005 21:02:47 -0400
# Received: from int-mx1.corp.redhat.com
#  (int-mx1.corp.redhat.com [172.16.52.254])	by mx1.redhat.com (8.12.11/8.12.11)
#  with ESMTP id j5F11EGn027669	for <bug-gawk@gnu.org>; Tue,
#  14 Jun 2005 21:01:14 -0400
# Received: from lacrosse.corp.redhat.com
#  (lacrosse.corp.redhat.com [172.16.52.154])	by int-mx1.corp.redhat.com
#  (8.11.6/8.11.6) with ESMTP id j5F11Eu01536	for <bug-gawk@gnu.org>; Tue,
#  14 Jun 2005 21:01:14 -0400
# Received: from [192.168.7.71] (vpn50-10.rdu.redhat.com [172.16.50.10])
# 	by lacrosse.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5F118s03225	for
#  <bug-gawk@gnu.org>; Tue, 14 Jun 2005 21:01:09 -0400
# Date: Tue, 14 Jun 2005 17:57:55 -0700
# From: Ulrich Drepper <drepper@redhat.com>
# Subject: non-decimal variable parameters cause crashes
# To: bug-gawk@gnu.org
# Message-id: <42AF7D13.5010901@redhat.com>
# Organization: Red Hat, Inc.
# MIME-version: 1.0
# Content-type: multipart/signed; micalg=pgp-sha1;
#  protocol="application/pgp-signature";
#  boundary=------------enig9DEC74140126C224E7DE3E54
# X-Accept-Language: en-us, en
# X-Enigmail-Version: 0.91.0.0
# User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
# Original-recipient: rfc822;arobbins@012.net.il
# X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on skeeve.com
# X-Spam-Level: 
# X-Spam-Status: No, hits=-4.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
# 	version=2.63
# Status: R
# 
# This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
# --------------enig9DEC74140126C224E7DE3E54
# Content-Type: text/plain; charset=UTF-8
# Content-Transfer-Encoding: quoted-printable
# 
# Running
# 
#   gawk --non-decimal-data -v a=3D0x1 'BEGIN { print a+0 }'
# 
# currently crashes.  More details including a patch at
# 
# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D160421
# 
# --=20
# =E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
# =E2=9E=A7 Mountain View, CA =E2=9D=96
# 
# 
# --------------enig9DEC74140126C224E7DE3E54
# Content-Type: application/pgp-signature; name="signature.asc"
# Content-Description: OpenPGP digital signature
# Content-Disposition: attachment; filename="signature.asc"
# 
# -----BEGIN PGP SIGNATURE-----
# Version: GnuPG v1.4.1 (GNU/Linux)
# Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
# 
# iD8DBQFCr30T2ijCOnn/RHQRAp9LAKC+w/vhXW73ps1Pxcy+VGPrT1Su+ACguPnV
# VstZcFJgJ5GZ1YvDExsOZZI=
# =xmXh
# -----END PGP SIGNATURE-----
# 
# --------------enig9DEC74140126C224E7DE3E54--
# 

# Added 4/2018 to make script self contained
BEGIN { a = "0x1" }

BEGIN { print a+0 }
