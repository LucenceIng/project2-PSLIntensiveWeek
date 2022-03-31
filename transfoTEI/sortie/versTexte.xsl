<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0"
    exclude-result-prefixes="xsl tei" >
    
    <!-- transformation depuis sorteEncodeeNum.xml vers rennes255-056-7.txt : la version qu'on peut mettre dans Pyrrha-->
    
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
   
   <xsl:template match="/">
           <xsl:apply-templates/> 
   </xsl:template>
 
    <xsl:template match="tei:w">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:choice|tei:expan|tei:ex|tei:corr|tei:reg">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader|tei:pc|tei:sic|tei:abbr|tei:am|tei:orig"/>
    
    
    
    
</xsl:stylesheet>