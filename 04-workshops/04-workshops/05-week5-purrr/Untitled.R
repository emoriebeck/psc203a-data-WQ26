tmp_fun <- function(x, y){
  if(all(y == 1)){
    return(NA)
  } else {
    mean(x)
  }
}
