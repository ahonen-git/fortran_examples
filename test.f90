!---------------------------------------------------
module sample
implicit none

! typeでクラスを定義する。
! 変数とメソッド（procedure）のみ定義する。
type, public :: people
   character(len=60), private :: f_name = "noname"
   character(len=60), private :: l_name = "noname"
   character(len=3) , private :: keisyou = "noname"
contains
   procedure :: set_name => people_set_name
   procedure :: display => people_display
end type people

! 継承はextendで行う。
type, extends(people) :: boy
contains
   procedure :: say_hi => boy_say_hi
end type boy


! コンストラクタ
! インスタンス生成時に実行されるメソッドのこと。
! initをpeopleでオーバーロードすることで、
! people()としたときにinitを実行させてインスタンスを生成する。
! peopleというクラス名と一致させなくても動作する。
! fortranではコンストラクタはなくても良い。
interface people
   module procedure init
end interface people

interface boy
   module procedure init_boy
end interface boy

contains

! resultは関数の戻り値を関数名の変数にしないための命令。
! ここでは生成しているクラスを返す。
! peopleの型で定義する。
type(people) function init(kei) result(self)
   character(len=3), intent(in) :: kei
   self%keisyou=kei
   write(6,*) "people instance is generated."
end function init

type(boy) function init_boy() result(self)
   write(6,*) "boy instance is generated."
end function init_boy


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

subroutine boy_say_hi(self)
   class(boy), intent(in) :: self
   write(*,*) "Hi, I am a boy."
end subroutine boy_say_hi

end module sample
!---------------------------------------------------
program test
   use sample
   implicit none

   type(people) :: a
   type(boy) :: b

   a=people("san")
   call a%set_name("Taro","Tanaka")
   call a%display()

   b=boy()
   call b%say_hi()

end program test
!---------------------------------------------------