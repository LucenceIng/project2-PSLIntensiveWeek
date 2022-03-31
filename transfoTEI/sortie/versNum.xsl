<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0"
    exclude-result-prefixes="xsl tei" >
    
    <!-- transformation depuis sorteEncodee.xml vers sortieEncodeeNum.xml : identifiants sur tous les mots -->
    
    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="no" indent="yes"/>
   
   <xsl:template match="/">
           <xsl:apply-templates/> 
   </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
     
    <xsl:template match="tei:w">
        <xsl:variable name="compte">
            <xsl:number count="tei:w" level="any" format="000001"/>
        </xsl:variable>
        <xsl:element name="w">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('rennes255_w_',$compte)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>