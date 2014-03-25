<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal"
    xmlns:d="http://www.daisy.org/ns/pipeline/data"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:sbs="http://www.sbs.ch/pipeline"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-inline-prefixes="px pxi d sbs"
    type="sbs:dtbook-to-latex.convert" name="convert" version="1.0">
    
    <p:input port="fileset.in"/>
    <p:input port="in-memory.in" sequence="true"/>
    <p:option name="output-dir" required="true"/>
    <p:output port="fileset.out">
        <p:pipe step="fileset" port="result"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe step="latex" port="result"/>
    </p:output>
    
    <p:import href="utils/normalize-uri.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>
    
    <pxi:normalize-uri>
        <p:with-option name="href" select="$output-dir"/>
    </pxi:normalize-uri>
    
    <px:fileset-create>
        <p:with-option name="base" select="string(c:result)"/>
    </px:fileset-create>
    
    <px:fileset-add-entry media-type="application/x-latex" name="fileset">
        <p:with-option name="href" select="replace(base-uri(/*),'^.*/([^/]*)\.[^/\.]*$','$1.tex')">
            <p:pipe step="convert" port="in-memory.in"/>
        </p:with-option>
    </px:fileset-add-entry>
    <p:sink/>
    
    <p:xslt>
        <p:input port="source">
            <p:pipe step="convert" port="in-memory.in"/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="2.0">
                    <xsl:import href="dtbook2latex_sbs.xsl"/>
                    <xsl:template match="/">
                        <xsl:element name="c:data">
                            <xsl:attribute name="content-type" select="'application/x-latex'"/>
                            <xsl:apply-imports/>
                        </xsl:element>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    
    <p:add-attribute match="/*" attribute-name="xml:base" name="latex">
        <p:with-option name="attribute-value"
                       select="//d:file[@media-type='application/x-latex']/resolve-uri(@href, base-uri(.))">
            <p:pipe step="fileset" port="result"/>
        </p:with-option>
    </p:add-attribute>
    
    <!-- TODO: copy images? -->
    
</p:declare-step>
