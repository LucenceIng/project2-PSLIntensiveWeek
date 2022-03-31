<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0"
    exclude-result-prefixes="#all"  
    >
    
    <!-- ref merge : https://stackoverflow.com/questions/32637761/sorting-several-xml-files-along-dates-and-merging-it-into-one-with-xslt
    -->
    
    <!-- ne pas oublier dans les parametres 
    d'indiquer -it:main -->
 
    <xsl:output encoding="UTF-8" method="xml" omit-xml-declaration="no" indent="yes"/>
        
    
    <xsl:template match='/' name="main">
        <xsl:result-document href="../sortie/sortie.xml" method="xml">
            
            <xsl:element name="TEI">
                
                
                <xsl:element name="teiHeader">
                    <xsl:element name="fileDesc">
                    <xsl:element name="titleStmt">
                        <xsl:element name="title">
                            <xsl:text>Lancelot en prose</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="publicationStmt">
                        <xsl:element name="p">
                            <xsl:text></xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="sourceDesc">
                        <xsl:element name="p">
                            <xsl:text>Fichier créé par transformation à partir de l'export réalisé dans escriptorium</xsl:text>
                        </xsl:element>
                    </xsl:element> 
                </xsl:element>
                </xsl:element>
                <xsl:variable name="facsi">
                    <xsl:perform-sort select="collection('file:////home/lucence/Documents/PSLIntensiveWeek/preparation/htr/donnees56-7/rennes255/export_chap56-7_lancelot255_pagexml_202203211810?select=*.xml')/*">
                        <xsl:sort select="."/>  
                    </xsl:perform-sort>
                </xsl:variable>
                
                <xsl:element name="facsimile">  
                    <xsl:for-each select="$facsi">
                        <xsl:apply-templates select="pc:PcGts"/>
                    </xsl:for-each>
                </xsl:element>
                <xsl:element name="text">
                    <xsl:element name="body">
                        <xsl:element name="p">
                            <xsl:for-each select="$facsi">
                                <xsl:apply-templates select="pc:PcGts/pc:Page"/>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>
 
    <xsl:template match="pc:PcGts">
        
        <xsl:element name="surface">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('f',pc:Page/substring-before(@imageFilename, '.png'))"/>
            </xsl:attribute>
            <xsl:element name="graphic">
                <xsl:attribute name="url">
                    <xsl:value-of select="pc:Page/@imageFilename"/>
                </xsl:attribute>
                <xsl:attribute name="height">
                    <xsl:value-of select="concat(pc:Page/@imageHeight,'px')"/>
                </xsl:attribute>
                <xsl:attribute name="width">
                    <xsl:value-of select="concat(pc:Page/@imageWidth,'px')"/>
                </xsl:attribute>
            </xsl:element>
            <xsl:apply-templates select="pc:TextRegion[descendant::pc:Unicode]" mode="facs"/>
            <xsl:apply-templates select="descendant::pc:TextLine[descendant::pc:Unicode]" mode="facs"/>
        </xsl:element>  
    </xsl:template>
    
    <xsl:template match="pc:Page">
        <xsl:element name="pb">
            <xsl:attribute name="n">
                <xsl:value-of select="substring-before(@imageFilename, '_default.jpg')"/>    
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="pc:TextRegion[contains(@id, 'textblock') and descendant::pc:Unicode]" mode="facs">
        <xsl:element name="zone">
            <xsl:attribute name="points">
                <xsl:value-of select="pc:Coords/@points"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pc:TextLine" mode="facs">
        <xsl:element name="zone">
            <xsl:attribute name="points">
                <xsl:value-of select="pc:Coords/@points"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pc:TextRegion[contains(@id, 'dummyblock') and descendant::pc:Unicode]">
        <xsl:element name="fw">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pc:TextRegion[contains(@id, 'textblock') and descendant::pc:Unicode]">
       
        <xsl:element name="cb">
            
            <xsl:attribute name="facs">
                <xsl:value-of select="concat('#', @id)"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="pc:TextLine|pc:TextEquiv">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="pc:Unicode">
        <xsl:element name="lb">
            <xsl:attribute name="facs">
                <xsl:value-of select="concat('#', ancestor::pc:TextLine/@id)"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="pc:Metadata"/>
    
</xsl:stylesheet>