with Gtkada.Builder; use Gtkada.Builder;


package Chat_Window_Callbacks is

   procedure Check_RightClick  (Object : access Gtkada_Builder_Record'Class);
   procedure Invite_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure History_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Games_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Smiley_Action  (Object : access Gtkada_Builder_Record'Class);

   function Check_If_Enter  (Object : access Gtkada_Builder_Record'Class) return Boolean;

end Chat_Window_Callbacks;
