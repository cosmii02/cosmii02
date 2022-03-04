#################
# Lihtne klass
#################
class Punkt:
  x=0
  y=0

p=Punkt()
p.y=7
print (p.x, p.y)


#################
# Meetod
#################
class Punkt:
  x=0
  y=0
  def tutvusta(self):
    print (self.x ," ja ", self.y)

p=Punkt()
p.y=7
p.tutvusta()


#################
# Konstruktor
#################
class Punkt:
  def __init__(self, ux, uy):
    self.x=ux
    self.y=uy
  def tutvusta(self):
    print (self.x ," ja ", self.y)

p=Punkt(3, 5)
p.tutvusta()
Punkt.tutvusta(p) #eelmisega samaväärne


#################
# Konstruktori valikparameeter
#################
class Tomat:
  def __init__(self, uus_suurus="pisike"):
      self.suurus=uus_suurus;

t1=Tomat()
t2=Tomat("suur");
print (t1.suurus+" "+t2.suurus)


#################
# Pärimine
#################
class Punkt:
  x=0
  y=0
  def tutvusta(self):
    print (self.x ," ja ", self.y)

class Punkt2(Punkt):
  def suurenda(self):
    self.x=self.x+1

p=Punkt2()
p.tutvusta()
p.suurenda()
p.tutvusta()


#################
# Tühi klass
#################
class tyhiklass:
  pass

koer=tyhiklass()
koer.nimi="Muri"

print (koer.nimi)


#################
# Klass ja väljad
#################
class tyhiklass:
  pass

koer=tyhiklass()
koer.nimi="Muri"
setattr(koer, "synniaasta", 1998) #samaväärne väärtuseomistus
print (koer.nimi)
print (vars(koer)) #koera küljes olevad muutujad
print (hasattr(koer, "nimi"))
print (getattr(koer, "nimi"))
if hasattr(koer, "synniaasta"):
  delattr(koer, "synniaasta")
del koer.nimi