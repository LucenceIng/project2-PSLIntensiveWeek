library("XML")
library("methods")
library("plotly")
library("dplyr")
library("ggplot2")
library("heatmaply")
library("plsgenomics")
library("purrr")


## sur div
# parser nos deux textes au format XML
Ao <- xmlParse(file = "Ao.xml")
Ez <- xmlParse(file = "Ez.xml")

#on récupère les noeuds des div
div_Ao = getNodeSet(Ao, "/tei:TEI//tei:body//tei:div", namespaces = c(tei = "http://www.tei-c.org/ns/1.0"))
div_Ez = getNodeSet(Ez, "/tei:TEI//tei:body//tei:div", namespaces = c(tei = "http://www.tei-c.org/ns/1.0"))

#avant la boucle, il faut modifier la valeur de i et de Ao_0XX (on récupère les div qui correspondent aux chapitres dans les deux témoins)
i <- 14
val <- 'Ao_014'
for (d in div_Ao){
  idAo = xmlGetAttr(d, 'xml:id')
  if (idAo==val){
  idEz = xmlGetAttr(d, 'corresp')
      mots_AF = getNodeSet(d, ".//tei:w", namespaces = c(tei = "http://www.tei-c.org/ns/1.0"))
      mots_MF = getNodeSet(div_Ez[[i]], ".//tei:w", namespaces = c(tei = "http://www.tei-c.org/ns/1.0"))
      liste_AF <- vector()
      for (mot in mots_AF) {
        lemme = xmlGetAttr(mot, 'lemma')
        liste_AF <- append(liste_AF, lemme)
      }
      liste_MF <- vector()
      for (mot in mots_MF) {
        lemme = xmlGetAttr(mot, 'lemma')
        liste_MF <- append(liste_MF, lemme)
      }
      AF <- unlist(liste_AF)
      MF <- unlist(liste_MF)
      m <- adist(AF,MF)
  }
}

#sur certains chap, trop lourd (réduire)
jpeg(paste("rplottest",i,".jpg"),width = length(liste_AF), height = length(liste_MF))
matrix.heatmap(m,breaks =c(0,0.5,1), col = c("red", "white"))
dev.off()

