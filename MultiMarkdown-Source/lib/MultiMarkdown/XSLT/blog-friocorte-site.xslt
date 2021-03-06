<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-XHTML converter by Fletcher Penney
	specifically designed for use with MultiMarkdown created XHTML
	
	This file converts a MultiMarkdown text file into an XHTML file 
	suitable for publishing on my web site, including a header, footer, 
	and sidebar.
	
	It also uses the title and date metadata in the output, and eventually
	may do something useful with tag metadata if I decide what I want to do.
	
-->

<!-- 
# Copyright (C) 2009  Fletcher T. Penney <fletcher@fletcherpenney.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xhtml xsl"

	version="1.0">

	<xsl:variable name="newline">
<xsl:text>
</xsl:text>
	</xsl:variable>
	
	<xsl:output method='xml' version="1.0" doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" doctype-system="http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd" indent="no"/>

	<!-- the identity template, based on http://www.xmlplease.com/xhtmlxhtml -->

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:head">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/templates/head.inc" -->]]></xsl:text>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:body">
		<xsl:copy>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/templates/header.inc" -->]]></xsl:text>
			<xsl:if test="/xhtml:html/xhtml:head/xhtml:title != ''">
				<h1 class="page-title"><a href=''><xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/></a></h1>
			</xsl:if>
			<xsl:if test="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'date']/@content != ''">
        <!-- date translation begin -->
        <xsl:variable name="maindate">
          <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'date']/@content" />
        </xsl:variable>
        <xsl:variable name="newdate">
          <xsl:value-of select="substring-before($maindate,'T')"/>
        </xsl:variable>
        <xsl:variable name="tmptime">
          <xsl:value-of select="substring-after($maindate,'T')"/>
        </xsl:variable>
        <xsl:variable name="newtime">
          <xsl:value-of select="substring-before($tmptime,'-')"/>
        </xsl:variable>
        <!-- date translation end -->
				<span class="byline vcard">By goozbach on <xsl:value-of select="$newdate"/> at <xsl:value-of select="$newtime"/>
				</span>
			</xsl:if>
			<xsl:if test="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'tags-disabled']/@content != ''">
				<div class="tags">Tags: <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'tags']/@content"/>
				</div>
			</xsl:if>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[<!--#include virtual="/templates/bottom.inc" -->]]></xsl:text>
		</xsl:copy>
	</xsl:template>
	

</xsl:stylesheet>
