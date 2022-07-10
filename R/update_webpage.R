update_webpage <- function() {
  system("rm -rf /net/www/export/home/hafri/einarhj/public_html/pkg/pgnapes/*")
  system("cp -rp docs/* /net/www/export/home/hafri/einarhj/public_html/pkg/pgnapes/.")
  system("chmod -R a+rX /net/www/export/home/hafri/einarhj/public_html/pkg/pgnapes")
}
