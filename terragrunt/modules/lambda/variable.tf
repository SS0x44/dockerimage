variable "example_var_1" { type = string }
variable "example_var_2" { type = number }
variable "example_var_3" { type = bool }
variable "example_var_4" { type = list(string) }
variable "example_var_5" { type = map(any) }
variable "example_var_6" {
  type = object({
    key1 = string
    key2 = number
  })
}
variable "example_var_7" { type = any }
variable "example_var_8" { type = string }
