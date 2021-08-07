
!---------------------------------------------------
module sample
implicit none

! typeでクラスを定義する。
! 変数とメソッド（procedure）のみ定義する。
type, public :: people
   character(len=60), private :: f_name = "noname"
   character(len=60), private :: l_name = "noname"
   character(len=3) , private :: keisyou
contains
   procedure :: set_name => people_set_name
   procedure :: display => people_display
end type people

! コンストラクタ：インスタンス生成時に実行されるメソッドのこと。
! initをpeopleでオーバーロードすることで、
! people()としたときにinitを実行させてインスタンスを生成する。
! peopleというクラス名と一致させなくても動作する。
! fortranではコンストラクタはなくても良い。
! オブジェクトを模擬しているだけなのか？
interface people
   module procedure init
end interface people

contains

! result文は関数の戻り値を関数名の変数にしないための命令。
! ここでは生成しているクラスを返す。
! peopleの型で定義する。
! functionの定義文では「::」を使わないので、「::」は入れない。
type(people) function init(kei) result(self)
   character(len=3), intent(in) :: kei
   self%keisyou=kei
   write(6,*) "people instance is generated."
end function init

! メソッドとなるサブルーチンでクラスの変数を使用するために
! peopleの型でselfを作る。
! selfは決まった名称ではない、thisとかでも良い。
subroutine people_set_name(self,f,l)
   class(people), intent(inout) :: self
   character(len=*) f,l
   self%f_name = f
   self%l_name = l
end subroutine people_set_name

subroutine people_display(self)
   class(people) self
   write(*,"(A10,X,A10,X,A3)") self%f_name, self%l_name, self%keisyou
end subroutine people_display

end module sample
!---------------------------------------------------
program test
   use sample
   implicit none

   type(people) :: a
   a=people("san")
   call a%set_name("Taro","Tanaka")
   call a%display()


end program test
!---------------------------------------------------