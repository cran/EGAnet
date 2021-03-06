#' \code{\link[EGAnet]{EGA}} Color Palettes
#'
#' Color palettes for plotting \code{\link[GGally]{ggnet2}} \code{\link[EGAnet]{EGA}}
#' network plots
#'
#' @param name Character.
#' Name of color scheme (see \code{\link[RColorBrewer]{RColorBrewer}}).
#' Defaults to \code{"polychrome"}.
#' \code{\link[EGAnet]{EGA}} palettes:
#'
#' \itemize{
#'
#' \item{\code{"polychrome"}}
#' {Default 20 color palette}
#'
#' \item{\code{"blue.ridge1"}}
#' {Palette inspired by the Blue Ridge Mountains}
#'
#' \item{\code{"blue.ridge2"}}
#' {Second palette inspired by the Blue Ridge Mountains}
#' 
#' \item{\code{"rainbow"}}
#' {Rainbow colors. Default for \code{\link[qgraph]{qgraph}}}
#'
#' \item{\code{"rio"}}
#' {Palette inspired by Rio de Janiero, Brazil}
#'
#'  \item{\code{"itacare"}}
#' {Palette inspired by Itacare, Brazil}
#'
#' }
#'
#' For custom colors, enter HEX codes for each dimension in a vector
#'
#' @param wc Vector.
#' A vector representing the community (dimension) membership
#' of each node in the network. \code{NA} values mean that the node
#' was disconnected from the network
#'
#' @author Hudson Golino <hfg9s at virginia.edu>, Alexander P. Christensen <alexpaulchristensen at gmail.com>
#'
#' @return Vector of colors for community memberships
#'
#' @examples
#' # Default
#' color_palette_EGA(name = "polychrome", wc = ega.wmt$wc)
#'
#' # Blue Ridge Moutains 1
#' color_palette_EGA(name = "blue.ridge1", wc = ega.wmt$wc)
#'
#' # Custom
#' color_palette_EGA(name = "#7FD1B9", wc = ega.wmt$wc)
#'
#' @export
#'
# Updated 17.12.2020
## Function to produce color palettes for EGA
color_palette_EGA <- function (name, wc)
{

  # All palettes
  all_palettes <- c(row.names(RColorBrewer::brewer.pal.info),
                    "polychrome", "blue.ridge1", "blue.ridge2",
                    "rainbow", "rio", "itacare"
                    )

  # Default palette
  ## Polychrome (20 colors)
  polychrome <- toupper(
    paste("#",
          c("F96F5D", "90DDF0", "C8D96F", "f9b16e", "f5c900",
            "ba42c0", "17BEBB", "9bafd9", "f27a7d", "f9c58d",
            "f7f779", "c5f9d7", "a18dce", "f492f0", "919bff",
            "C792DF", "60b6f1", "f9a470", "bc556f", "f7a2a1"
          ), sep = "")
  )


  # Check for custom
  if(!all(name %in% all_palettes)){

    if(length(name) != max(wc, na.rm = TRUE)){
      return(get("polychrome")[color.sort(wc)])
      warning(
        paste(
          "Length of 'color.palette' does not equal the number of dimensions (",
          max(wc, na.rm = TRUE),
          ") in the data.\nUsing default: color.palette = 'polychrome'",
          sep = ""
        )
      )
    }

    if(length(grep("#", name)) != length(name)){

      # Missing hashtags
      targets <- setdiff(1:length(name), grep("#", name))

      name[targets] <- paste("#", name[targets], sep = "")

    }

    return(name[color.sort(wc)])

  }else{

    # Check for RColorBrewer palette
    if(name %in% row.names(RColorBrewer::brewer.pal.info)){

      return(RColorBrewer::brewer.pal(max(color.sort(wc), na.rm = TRUE), name)[color.sort(wc)])

    }else{# EGA palettes

      # Make name lowercase
      name <- tolower(name)

      ## Polychrome (20 colors)
      polychrome <- toupper(
        paste("#",
              c("F96F5D", "90DDF0", "C8D96F", "f9b16e", "f5c900",
                "ba42c0", "17BEBB", "9bafd9", "f27a7d", "f9c58d",
                "f7f779", "c5f9d7", "a18dce", "f492f0", "919bff",
                "C792DF", "60b6f1", "f9a470", "bc556f", "f7a2a1"
              ), sep = "")
      )

      ## Blue Ridge Mountains 1 (7 colors)
      blue.ridge1 <- toupper(
        paste("#",
              c("fdcd9b", "fde8a9", "fdb184",
                "7f616e", "4c6e98", "24547e", "272a39"
              ), sep = "")
      )

      ## Blue Ridge Mountains 2 (10 colors)
      blue.ridge2 <- toupper(
        paste("#",
              c("26405b", "facf92", "497397",
                "8c7f8e", "a5a9a9", "68788b",
                "e2a187", "e3ccb5", "c48480", "fcac6c"
              ), sep = "")
      )

      ## Blue Ridge Mountains 2 (10 colors)
      blue.ridge2 <- toupper(
        paste("#",
              c("26405b", "facf92", "497397",
                "8c7f8e", "a5a9a9", "68788b",
                "e2a187", "e3ccb5", "c48480", "fcac6c"
              ), sep = "")
      )
      
      # Rainbow
      rainbow <- grDevices::rainbow(max(as.numeric(factor(wc)), na.rm = TRUE))
      
      ## Rio (10 colors)
      rio <- toupper(
        paste("#",
              c("fac9af", "a95c5b", "322a30",
                "654145", "f09b5f", "985e36",
                "ea897c", "9c8062", "524954", "54544c"
              ), sep = "")
      )

      ## Itacare (10 colors)
      itacare <- toupper(
        paste("#",
              c("232b17", "cbbda4", "2888ab",
                "0581c9", "7e8056", "d9e7e6",
                "8ec0c5", "a58a60", "ad9342", "a96c2e"
              ), sep = "")
      )

      if(exists(name)){
        return(get(name)[color.sort(wc)])
      }else{
        return(get("polychrome")[color.sort(wc)])
      }

    }

  }
}
